require('malihu-custom-scrollbar-plugin')

$(document).ready(function () {

    $("#sidebar").mCustomScrollbar({
         theme: "light-thin"
    });

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
        $('.collapse.in').toggleClass('in');
        // and also adjust aria-expanded attributes we use for the open/closed arrows
        // in our CSS
        $('a[aria-expanded=true]').attr('aria-expanded', 'false');
    });

});
