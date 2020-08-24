require('bootstrap')
require('summernote/dist/summernote-bs4')
require('custom/summernote-table-of-contents')

let ImageButton = function (context) {
    let ui = $.summernote.ui;

    let button = ui.button({
        contents: '<i class="fa fa-camera" aria-hidden="true"></i>',
        tooltip: 'Image',
        click: function () {
            let options = document.getElementsByClassName('image_options')[0];

            if (options.classList.contains('hidden')) {
                options.className = options.className.replace("hidden", "");
            } else {
                options.classList.add("hidden");
            }
        }
    })

    return button.render()
}

let VideoButton = function (context) {
    let ui = $.summernote.ui;

    let button = ui.button({
        contents: '<i class="fa fa-play" aria-hidden="true"></i>',
        tooltip: 'Video',
        click: function () {
            let options = document.getElementsByClassName('video_options')[0];
        
            if (options.classList.contains('hidden')) {
                options.className = options.className.replace("hidden", "");
            } else {
                options.classList.add("hidden");
            }
        }
    })

    return button.render()
}

$(document).on('turbolinks:load', function() {
    $('#summernote').summernote({
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'italic', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'btnImage', 'btnVideo']],
            ['tableOfContents'],
            ['view', ['fullscreen', 'codeview', 'help']]
          ],
        buttons: {
            btnImage: ImageButton,
            btnVideo: VideoButton
        },
        tabDisable: true
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
        let p = document.createElement('p')
        let br = document.createElement('br')
        video.setAttribute('src', url)
        video.setAttribute('allowfullscreen', true)
        video.setAttribute('frameborder', '0')
        video.setAttribute('controls', 'controls')
        video.setAttribute('poster', thumbnail)
        video.setAttribute('class', 'video-player')

        let range = $.summernote.range

        $('#summernote').summernote('insertNode', video)
        $('#summernote').summernote('insertNode', br)
        // $('#summernote').summernote('editor.setLastRange', range.createFromNodeAfter(video).select())
        console.log($('#summernote').summernote('editor.getLastRange'))
    })
})