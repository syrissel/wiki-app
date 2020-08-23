$(document).on('turbolinks:load', function () {
    $('.admin-item-wrapper').hover(function () {
        $(this).children('.icon').attr('animation', 'burst')
        $(this).children('p').animate({
            'font-size': '30px'
        }, 250)
        $(this).parent().parent().addClass('custom-shadow')
    }, function () {
        $(this).children('.icon').removeAttr('animation')
        $(this).children('p').animate({
            'font-size': '1rem'
        }, 250)
        $(this).parent().parent().removeClass('custom-shadow')
    })
})
