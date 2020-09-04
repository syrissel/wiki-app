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
        contents: '<i class="fa fa-video-camera" aria-hidden="true"></i>',
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

let PdfButton = function (context) {
    let ui = $.summernote.ui;

    let button = ui.button({
        contents: '<i class="fa fa-file-pdf-o" aria-hidden="true"></i>',
        tooltip: 'PDF',
        click: function () {
            let options = document.getElementsByClassName('pdf_options')[0];
        
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
            ['para', ['ul', 'ol', 'paragraph', 'height']],
            ['table', ['table']],
            ['insert', ['link', 'btnImage', 'btnVideo', 'btnPdf']],
            ['tableOfContents'],
            ['view', ['fullscreen', 'help']]
        ],
        placeholder: 'Compose a wiki',
        buttons: {
            btnImage: ImageButton,
            btnVideo: VideoButton,
            btnPdf:   PdfButton
        },
        tabDisable: true,
        disableDragAndDrop: true,
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48']
    });

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

    $('#pdf_button').click(function() {
        let url = $("input[name='pdf']:checked").data('pdf').url
        let iframe = document.createElement('iframe')
        iframe.setAttribute('src', url)
        iframe.setAttribute('width', '100%')
        iframe.setAttribute('height', '750px')
        $('#summernote').summernote('insertNode', iframe)
    })

    $('#range_test_button').click(function () {
        let range = new Range();
        const summernote = $('.note-editable')[0]

        range.setStart(summernote, 0);
        range.setEnd(summernote, 0);
        // let rng = range.create(summernote, 0, summernote, 0)
        document.getSelection().removeAllRanges();
        document.getSelection().addRange(range);
    })
})