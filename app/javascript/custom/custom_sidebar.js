$(document).on('turbolinks:load', function(){
    $('#btn_show_sidebar').click(function() {
        if ($('.sidebar').width() === 0) {
            $('.sidebar').animate({'width': '400px'}, 50);
            $('.header_container').animate({'margin-left': '400px'}, 50);
            $('.header_container').animate({'width': $(window).width() - 400}, 300)

            if ($(window).width() < 1700) {
                $('#middle_content').animate({'margin-left': '400px'}, 50);
            }

            if ($(window).width() < 1260) {
                $('#middle_content').animate({'width': $(window).width() - 400}, 300)
            }

            $('#btn_show_sidebar').html("<box-icon name='x' size='60px' color='#d4af37' ></box-icon>")
        } else {
            $('.sidebar').animate({'width': '0'}, 50);
            $('.header_container').animate({'margin-left': '0'}, 50);
            $('.header_container').animate({'width': '100%'}, 0)

            $('#middle_content').removeAttr('style')
            
            $('#btn_show_sidebar').html("<box-icon name='menu' size='60px' color='#d4af37'></box-icon>")
        }
    })
})