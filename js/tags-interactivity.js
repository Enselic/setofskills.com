define(['jquery'], function($) {
    'use strict';

    $(".post-list-header").each(function() {
        $(this).click(function(){
            $(this).nextAll(".post-list:first").slideToggle();
            $(this).parent().toggleClass('expanded');
        });
    });
});
