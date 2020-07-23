// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require dataTables/jquery.dataTables
//= require activestorage
//= require turbolinks
//= require bootstrap
//= require jquery.easy-autocomplete
//= require_tree .

$(document).on('change', '#incumbentOffice', function(){
    debugger;
    if($(this).prop('checked')){
        $('#incumbentOfficePicker').removeAttr('disabled');
        $('#reElection').removeAttr('disabled');
    } else {
        $('#incumbentOfficePicker').attr('disabled', 'disabled');
        $('#reElection').attr('disabled', 'disabled');
    }
});

$(document).on('change', '#runningFor', function(){
    debugger;
    if($(this).prop('checked')){
        $('#runningForPicker').removeAttr('disabled');
        
    } else {
        $('#runningForPicker').attr('disabled', 'disabled');
        
    }
});

$(document).on('change', '#reElection', function(){
    debugger;
    if($(this).prop('checked')){
        $('#runningFor').attr('disabled', 'disabled');
    } else {
        $('#runningFor').removeAttr('disabled');
        
    }
});



