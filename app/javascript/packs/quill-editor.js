import Quill from 'quill';
import 'custom/quill-classes/VideoBlot';

export default Quill;

document.addEventListener("turbolinks:load", function(event) {

	var quill = new Quill('#editor', {
		modules: {
		toolbar: {
			container: '#toolbar'
		}
		},
		placeholder: 'Compose an epic...',
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
});