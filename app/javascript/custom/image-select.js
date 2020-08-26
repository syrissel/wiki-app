$(document).on('turbolinks:load', function () {
    var maxHeight = 0;
    $('#images li img').each(function() {
        if ($(this).height() > maxHeight) {
            maxHeight = $(this).height();
        }
    });
    $('#images li img').height(maxHeight)
})