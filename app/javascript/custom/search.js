require('bootstrap')

$(document).on('turbolinks:load', function() {
    $('#btn_filter_options').click(function() {

        // if ($('#filter_options').hasClass('d-none')) {
        //     $('#filter_options').removeClass('d-none')
        // } else {
        //     $('#filter_options').addClass('d-none')
        // }
        $(this).dropdown('toggle')
    })

    $('#btn_other_search_options').click(function() {

        // $('.form-check-input').prop('checked', false)

        // $('.form-check-input').attr('disabled', 'disabled')
        $('#modal_category_select').modal('show')
    })

    $('#btn_search_help').click(function() {
        $('#search_help_modal').modal('show')
    })

    $('input[name="/pages[category_search]"]').change(function() {
        // if ($(this).is(':checked'))
        //     $('.form-check-input').prop('checked', false)
        $('#btn_other_search_options').html($('input[name="/pages[category_search]"]:checked').data('name'))
        $('#link_remove_category_filter').removeClass('d-none')
        $('#_pages_category').attr('disabled', 'disabled');
    })

    $('#link_remove_category_filter').click(function() {
        $('input[name="/pages[category_search]"]:checked').prop('checked', false)
        $('#btn_other_search_options').html('none')
        $('#_pages_category').removeAttr('disabled')
        $(this).addClass('d-none')
    })

    $('.user-menu').click(function() {
        $(this).dropdown('toggle')
    })

    $('.dropdown-menu').click(function(event) {
        event.stopPropagation()
    })

    $('#modal_category_select').click(function(event) {
        event.stopPropagation()
    })

    $('#search_help_modal').click(function(event) {
        event.stopPropagation()
    })
})

