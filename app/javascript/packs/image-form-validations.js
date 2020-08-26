$(document).on('turbolinks:load', function () {
    $('#new_image').submit(function () {
        let name = $.trim($('#image_name').val())

        if (name.length < 1) {
            $('#image_name').addClass('is-invalid')
            event.preventDefault();
        }
    })
})