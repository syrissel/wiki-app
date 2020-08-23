$(document).ready(function () {
    $('.admin-item-wrapper').hover(function () {
        if ($(this).children('.icon').attr('name') == 'cog') {
            $(this).children('.icon').attr('animation', 'spin')
        } else {
            $(this).children('.icon').attr('animation', 'tada')
        }
        $(this).children('h4').animate({
            'font-size': '30px'
        }, 250)
        $(this).parent().parent().addClass('custom-shadow')
    }, function () {
        $(this).children('.icon').removeAttr('animation')
        $(this).children('h4').animate({
            'font-size': '1.5rem'
        }, 250)
        $(this).parent().parent().removeClass('custom-shadow')
    })
})
