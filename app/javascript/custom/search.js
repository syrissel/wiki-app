require('bootstrap')

$(document).on('turbolinks:load', function() {
    $('#btn_filter_options').click(function() {

        if ($('#filter_options').hasClass('d-none')) {
            $('#filter_options').removeClass('d-none')
        } else {
            $('#filter_options').addClass('d-none')
        }
    })

    $('#btn_other_search_options').click(function() {

        // $('.form-check-input').prop('checked', false)
        // $('input[name="/pages[category]"]').change(function() {
        //     if ($(this).is(':checked'))
        //         $('.form-check-input').prop('checked', false)
        // })
        // $('.form-check-input').attr('disabled', 'disabled')
        $('#modal_category_select').modal('show')
    })
})

