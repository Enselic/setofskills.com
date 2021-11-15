/*

node_modules/requirejs/bin/r.js -o build.js

*/

requirejs.config({
    shim: {
        "jquery.lazyload": ["jquery"]
    }
});

requirejs(['jquery', 'jquery.lazyload', 'logo-interactivity', 'blog-post-interactivity', 'tags-interactivity'], function($) {
    $('img[data-original]').lazyload();
});
