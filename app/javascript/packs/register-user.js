$(document).on('turbolinks:load', function() {
    $('#user_user_level_id').change(function() {
        if ($(this).val() > 1) {
            $('#email').removeClass('d-none')
        } else {
            $('#email').addClass('d-none')
        }
    })
})