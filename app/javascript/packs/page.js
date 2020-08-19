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

    // Validate before form submission.
    $('#page_form').submit(function(event) {
		let valid = true;
		let title = $.trim($('#page_title').val());
		let category = $('input[name="page[category_id]"]:checked').val();

		if (title.length < 1) {
			$('#title_error').html('Please enter a title.');
			valid = false;
		} else {
			$('#title_error').html('');
		}

		if (category == null) {
			$('#category_error').html('Please select a category.');
			valid = false;
		} else {
			$('#category_error').html('');
		}

		if (!valid) {
			event.preventDefault();
		} else {
			$(this).submit();
		}
	});

}, false);
