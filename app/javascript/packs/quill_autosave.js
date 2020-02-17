function load() {
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

  // Check for unsaved data
  window.onbeforeunload = function() {
    if (change.length() > 0) {
      alert('There are unsaved changes. Are you sure you want to leave?');
    }
  }

  // Load saved contents
  setTimeout(window.onload = function() {
    var storedText = JSON.parse(localStorage.getItem('storedText'));
    
    if (editor !== null) $('.ql-editor').html(storedText);
  }, 500);
}

document.addEventListener('turbolinks:load', load, false);
