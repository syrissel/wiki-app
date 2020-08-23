$(document).on('turbolinks:load', function () {
    $('.admin-item-wrapper').hover(function () {
        if ($(this).children('.icon').attr('name') == 'cog') {
            $(this).children('.icon').attr('animation', 'spin')
        } else {
            $(this).children('.icon').attr('animation', 'tada')
        }
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
