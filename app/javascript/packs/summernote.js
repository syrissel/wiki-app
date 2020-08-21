
require('summernote/dist/summernote-lite')

$(document).on('turbolinks:load', function() {
    $('#summernote').summernote({
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['fullscreen', 'codeview', 'help']],
            ['btnHello', ['hello']]
          ],
        buttons: {
            hello: helloButton
        },
        tabDisable: false
    });

    var helloButton = function (context) {
        var ui = $('#summernote').ui;
      
        // create button
        var button = ui.button({
          contents: '<i class="fa fa-child"></i>',
          tooltip: 'hello',
          click: function () {
            // invoke insertText method with 'hello' on editor module.
            context.invoke('editor.insertText', 'hello');
          }
        });
      
        return button.render();   // return button as jquery object
      }

    let ImageButton = function (context) {
        let ui = $.summernote.ui;

        let button = ui.button({
            contents: '<p>Text</p>',
            tooltip: 'Add a video'
        })

        return button.render()
    }

    $('#image_button').click(function() {
        let url = $("input[name='image']:checked").data('image').url;

        $('#summernote').summernote('insertImage', url, function($image) {
            $image.css('padding', '10px')
        })
    });

    $('#video_button').click(function() {
        let url = $("input[name='video']:checked").data('video').url;
        let thumbnail = $("input[name='video']:checked").data('thumbnail');
        let video = document.createElement('video')
        video.setAttribute('src', url)
        video.setAttribute('allowfullscreen', true)
        video.setAttribute('frameborder', '0')
        video.setAttribute('controls', 'controls')
        video.setAttribute('poster', thumbnail)
        video.setAttribute('class', 'video-player')

        $('#summernote').summernote('insertNode', video)
    })
})