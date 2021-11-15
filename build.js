/*

node_modules/requirejs/bin/r.js -o build.js

*/
({
    baseUrl: "js",
    shim: {
        "jquery.lazyload": ["jquery"]
    },
    name: "main",
    out: "js/main-build-.js" /* manually append with md5 of contents */
})
