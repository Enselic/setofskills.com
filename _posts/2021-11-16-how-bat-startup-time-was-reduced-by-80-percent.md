---
layout: post
title: How bat now starts 80% faster
date: '2021-11-15T16:56:00.004+02:00'
author: Martin Nordholts
tags: [bat]
---

`bat` is a great tool. It is a `cat` clone with syntax highlighting. With the latest [release](https://github.com/sharkdp/bat/releases/tag/v0.19.0) it starts *80% faster* than before. But getting there was not easy. Read on to learn why it was tricky and how it was achieved.

First, some performance numbers:

```
            bat startup time

       |
 100ms |    =====
       |    =====
  80ms |    =====
       |    =====
  60ms |    =====
       |    =====
  40ms |    =====
       |    =====
  20ms |    =====     =====
       |    =====     =====
       +-----------------------
           v0.18.3   v0.19.0
```

It takes `bat v0.18.3` *105 ms* to syntax highlight a hello world Rust program
on my low-end desktop. It takes `bat v0.19.0` only *20 ms* to perform the same
task. It may seem like *80 ms* is nothing, bur the difference is remarkable. It
FEELS great when your eyes get instant feedback when your fingers press RETURN.

Why is bat v0.18.3 that slow? It is because during startup, bat loads the syntax
definitions of all 160+ languages that are embedded in the bat binary before it
begins to do any highlighting. So to somehow make bat start faster, we must find
an alternative approach.

On first glance, the solution seems obvious. We should only load 1 syntax and 1
theme. That will be much faster. But its not that simple. syntaxes have
dependencies among them. For example, the HTML syntax depends on thr CSS syntax
for inline display of CSS in html files. That is just one example. The
dependencies among syntaxes is actually a mess. Here is a graphviz diagram with
all dependencies visualized
([source](https://github.com/sharkdp/bat/pull/1860#issuecomment-925303963)).

<a href="/img/sublime-syntax-dependencies-2021-09-22.jpg"><img
src="/img/sublime-syntax-dependencies-2021-09-22.jpg" width="500" /></a>

To complicate things further; syntect - the library bat uses - only works with
syntax sets. A syntax set is a pre-linked data structure with contexts that refer to other contexts. It is very efficient.


bat uses syntect, which is a library for syntax highlighting using Sublime Text syntax definitions. If you want to learn how such syntax definitions are constructed, read the official docs: todo. For the purposes of this blog post, it is however sufficient to know that it is very common for Sublime Syntax definitions to refer  to each other. For example, when the Markdown syntax definition encounters a rust code block like

```rust
fn hello() {}
```

it will reference the existing Rust syntax definition rather than re-implementing syntax highlighting for Rust.

In order to deal with this complexity in a performant way, syntect uses a linking step when building syntaxes. Syntaxes are serialized to a binary blob that is embedded into the bat binary.

When bat starts, the binary blob must be unpacked so that the linked data structures can be passed to syntect. This
