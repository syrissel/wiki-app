$(document).on('turbolinks:load', function () {
    $('.admin-item-wrapper').hover(function () {
        $(this).children('.icon').attr('animation', 'burst')
        $(this).parent().parent().addClass('custom-shadow')
    }, function () {
        $(this).children('.icon').removeAttr('animation')
        $(this).parent().parent().removeClass('custom-shadow')
    })
})
