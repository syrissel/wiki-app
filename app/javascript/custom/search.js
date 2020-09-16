$(document).on('turbolinks:load', function() {
    $('#btn_filter_options').click(function() {

        if ($('#filter_options').hasClass('d-none')) {
            $('#filter_options').removeClass('d-none')
        } else {
            $('#filter_options').addClass('d-none')
        }
    })
})

