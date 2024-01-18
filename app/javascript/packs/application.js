// app/javascript/packs/application.js

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "bootstrap";


import jQuery from "jquery";
window.$ = window.jQuery = jQuery;

import "@nathanvda/cocoon";
// ... any other libraries ...

Rails.start();
Turbolinks.start();
ActiveStorage.start();

console.log('Hello World from Webpacker')

$(document).on('turbolinks:load', function () {

    $('form').on('click', '.remove_record', function (event) {
        $(this).prev('input[type=hidden').val('1');
        $(this).closest('tr').hide();
        return event.preventDefault();
    });

    $('form').on('click', '.add_fields', function (event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $('.fields').append($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});
