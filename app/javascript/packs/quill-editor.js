const Quill = require('quill');
// import ImageResize from 'quill-image-resize-module';
// import BlotFormatter from 'quill-blot-formatter';
import BlotFormatter from 'quill-blot-formatter'
import 'custom/quill-classes/VideoBlot';
import 'custom/quill-classes/ImageBlot';
const Delta = Quill.import('delta');

Quill.register('modules/blotFormatter', BlotFormatter);

// Quill.register('modules/imageResize', ImageResize);
export default Quill;

document.addEventListener("turbolinks:load", function(event) {


	var quill = new Quill('#editor', {
		modules: {
			toolbar: {
				container: '#toolbar'
			},
			blotFormatter: {}
		},
		placeholder: 'Compose a document...',
		theme: 'snow'
	});

	// Insert video embed into editor.
	$('#video_button').click(function() {
		
		// Get the user's current cursor position.
		let range = quill.getSelection(true);

		// Insert line break so that cursor will show beneath the video embed.
		quill.insertText(range.index, '\n', Quill.sources.USER);
		
		// Grab selected radio button by name. Return video path from database.
		let url = $("input[name='video']:checked").data('video').url;

		// Insert the video embed.
		quill.insertEmbed(range.index + 1, 'db-video', url, Quill.sources.USER);

		// Adjust height and width of video.
		quill.formatText(range.index + 1, 1, { height: '360', width: '640' });

		// Show cursor.
		quill.setSelection(range.index + 2, Quill.sources.USER);
	});

	$('#image_button').click(function() {
		let range = quill.getSelection(true);
		quill.insertText(range.index, '\n', Quill.sources.USER);
		
		// Grab selected radio button by name. Return image path from database.
		let url = $("input[name='image']:checked").data('image').url;
		quill.insertEmbed(range.index, 'custom-image', url, Quill.sources.USER);
		quill.setSelection(range.index + 2, Quill.sources.SILENT);
		quill.insertText(range.index, '\n', Quill.sources.USER);
	});

	// Store accumulated changes
	let change = new Delta();

	quill.on('text-change', function(delta) {
		change = change.compose(delta);
	});

	// Save periodically
	setInterval(function() {
		if (change.length() > 0) {
			console.log('Saving changes...', change);
			// Save the entire updated text to localStorage
			const data = JSON.stringify(quill.root.innerHTML);
			localStorage.setItem('storedText', data);
			change = new Delta();
		}
	}, 1000);

	// Load saved contents
	setTimeout(window.onload = function() {
		var storedText = JSON.parse(localStorage.getItem('storedText'));
		
		if (editor !== null) $('.ql-editor').html(storedText);
	}, 500);

	// Validate before form submission.
	$('#page_form').submit(function(event) {
		let valid = true;
		let title = $.trim($('#page_title').val());
		let category = $('input[name="page[category_id]"]:checked').val();
		var postContentInput = document.querySelector('#post-content');
		postContentInput.value = quill.root.innerHTML;

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
		}

		// Clear wiki contents in local storage.
		localStorage.clear();
	});
});