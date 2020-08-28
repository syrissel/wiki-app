/*
Author:      Steph Mireault
Date:        circa Winter 2019/2020
Description: Various event listeners for functionality on the page show and edit.
*/

document.addEventListener('turbolinks:load', function() {

    // Show or hide the video select window.
    $('.show-video-options').click(function() {
        let options = document.getElementsByClassName('video_options')[0];
        
        if (options.classList.contains('hidden')) {
            options.className = options.className.replace("hidden", "");
        } else {
            options.classList.add("hidden");
        }
    });
    
    // Show or hide the image select window.
    $('.show-image-options').click(function() {
        let options = document.getElementsByClassName('image_options')[0];

		if (options.classList.contains('hidden')) {
			options.className = options.className.replace("hidden", "");
		} else {
			options.classList.add("hidden");
		}
    });

    // Show or hide the category select window.
    $('.show-category-options').click(function() {
        let options = document.getElementsByClassName('category_select')[0];

		if (options.classList.contains('hidden')) {
			options.className = options.className.replace("hidden", "");
		} else {
			options.classList.add("hidden");
		}
    });
    $('input[name="page[category_id]"]').change(function() {
        $('#selected_category').html('Selected: ' + $('input[name="page[category_id]"]:checked').data('name'))
    })

    $('#new_page').submit(function(event) {

        if ($('input[name="page[category_id]"]:checked').val() == null) {
            $('#category_error').html('Please select a category.')
            event.preventDefault();
        }
    })

}, false);
