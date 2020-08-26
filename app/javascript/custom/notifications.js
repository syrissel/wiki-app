$(document).on('turbolinks:load', function () {
    $('#notification_bell').click(function () {
        if ($('#notifications').css('display') == 'block') {
            $('#notifications').hide()
        } else {
            $('#notifications').show()
        }
    })
})