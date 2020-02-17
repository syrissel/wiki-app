function load() {


let BlockEmbed = Quill.import('blots/block/embed');
let Inline = Quill.import('blots/inline'); 
class MarkBlot extends Inline { } 
MarkBlot.blotName = 'mark'; 
MarkBlot.tagName = 'mark'; 
Quill.register(MarkBlot);


let Delta = Quill.import('delta');
let Embed = Quill.import('blots/block/embed');



class Border extends Embed {

  static create(value) {
    let node = super.create(value);
    
  }
}
Border.blotName = 'border';
Border.tagName = 'border';
Quill.register(Border);

var customBorderHandler = function() {
  var range = quill.getSelection();
  var selectedContent = quill.getContents(range.index, range.length);

  if (range) {
    quill.insertEmbed(range.index, 'border', "null");
  }
}

class HR extends Embed { 
  static create(value) {
      let node = super.create(value);
      // give it some margin
      node.setAttribute('style', "height:0px; margin-top:10px; margin-bottom:10px;");
      return node;
  }
}
HR.blotName = 'hr';
HR.tagName = 'hr';
Quill.register(HR);

var customHrHandler = function(){
  // get the position of the cursor
  var range = quill.getSelection();
  if (range) {
      // insert the <hr> where the cursor is
      quill.insertEmbed(range.index,"hr","null");
  }
}

Quill.register({
  'formats/hr': HR
});



class ImageBlot extends BlockEmbed {
static create(url) {
  let node = super.create();
  node.setAttribute('class', 'quill_image_container');
  let imgNode = document.createElement('img');
  imgNode.setAttribute('src', url);
  // let sliderNode = document.createElement('input');
  // sliderNode.setAttribute('type', 'range');
  // sliderNode.setAttribute('min', '20');
  // sliderNode.setAttribute('max', '100');
  // sliderNode.setAttribute('value', '100')
  // sliderNode.setAttribute('onchange', 'adjustWidth(this)');
  //sliderNode.setAttribute('class', 'image_resize_slider');
  //imgNode.setAttribute('display', 'inline');
  node.appendChild(imgNode);
  //node.appendChild(sliderNode);

  return node;
}

// static value(domNode) {
// 	return domNode.querySelector('img').getAttribute('src');
// }

static formats(node) {
  let format = {};
  if (node.hasAttribute('height')) {
    format.height = node.getAttribute('height');
  }
  if (node.hasAttribute('width')) {
    format.width = node.getAttribute('width');
  }
  return format;
}

static value(node) {
  return node.getAttribute('src');
}

format(name, value) {
  // Handle unregistered embed formats
  if (name === 'height' || name === 'width') {
    if (value) {
      this.domNode.setAttribute(name, value);
    } else {
      this.domNode.removeAttribute(name, value);
    }
  } else {
    super.format(name, value);
  }
}
}
ImageBlot.blotName = 'custom-image';
ImageBlot.tagName = 'div';
Quill.register(ImageBlot);

$('#image_button').click(function() {
let range = quill.getSelection(true);
quill.insertText(range.index, '\n', Quill.sources.USER);

// Grab selected radio button by name. Return image path from database.
//let url = $("input[name='image']:checked").data('image').url;
let url = $("input[name='image']:checked").data('image').url;
//quill.insertText(range.index, '<p>', Quill.sources.USER);
quill.insertEmbed(range.index, 'custom-image', url, Quill.sources.USER);
//quill.insertText(range.index, '</p>', Quill.sources.USER);
//quill.formatText(range.index + 1, 1, { height: '360', width: '640' });
quill.setSelection(range.index + 2, Quill.sources.SILENT);
});

class VideoBlot extends BlockEmbed {
static create(url) {
  let node = super.create();
  let thumbnail = $("input[name='video']:checked").data('thumbnail');
  node.setAttribute('src', url);
  // Set non-format related attributes with static values
  node.setAttribute('frameborder', '0');
  node.setAttribute('allowfullscreen', true);
  node.setAttribute('controls', 'controls');
  node.setAttribute('class', 'video-player');
  node.setAttribute('poster', thumbnail);

  return node;
}

static formats(node) {
  // We still need to report unregistered embed formats
  let format = {};
  if (node.hasAttribute('height')) {
    format.height = node.getAttribute('height');
  }
  if (node.hasAttribute('width')) {
    format.width = node.getAttribute('width');
  }
  return format;
}

static value(node) {
  return node.getAttribute('src');
}

format(name, value) {
  // Handle unregistered embed formats
  if (name === 'height' || name === 'width') {
    if (value) {
      this.domNode.setAttribute(name, value);
    } else {
      this.domNode.removeAttribute(name, value);
    }
  } else {
    super.format(name, value);
  }
}
}
VideoBlot.blotName = 'db-video';
VideoBlot.tagName = 'video';
Quill.register(VideoBlot);


$('#video_button').click(function() {
let range = quill.getSelection(true);
quill.insertText(range.index, '\n', Quill.sources.USER);

// Grab selected radio button by name. Return video path from database.
let url = $("input[name='video']:checked").data('video').url;
quill.insertEmbed(range.index + 1, 'db-video', url, Quill.sources.USER);
quill.formatText(range.index + 1, 1, { height: '360', width: '640' });
quill.setSelection(range.index + 2, Quill.sources.SILENT);
});


var form = document.querySelector('#page_form');
var quill = new Quill('#editor', {
  modules: {
    imageResize: {
      displaySize: true
    },
    toolbar: {
      container: '#toolbar',
      handlers: {
        'hr': customHrHandler,
        'border':customBorderHandler
      }
    }
  },
  theme: 'snow',
  placeholder: 'Compose your wiki here...'
});

// Submit text editor content to database.
form.onsubmit = function() {
var postContentInput = document.querySelector('#post-content');
postContentInput.value = quill.root.innerHTML;

// Clear saved wiki contents in local storage
localStorage.clear();
};


$(function() {
function readURL(input) {
if (input.files && input.files[0]) {
  var reader = new FileReader();

  reader.onload = function (e) {
    $('#img_prev').attr('src', e.target.result);
  }
  reader.readAsDataURL(input.files[0]);
}
}

$("#preview_upload").change(function(){
$('#img_prev').removeClass('hidden');
readURL(this);
});
});

function showVideoOptions() {
  let options = document.getElementsByClassName('video_options')[0];
  //options.className = options.className.replace('hidden', '');
  if (options.classList.contains('hidden')) {
    options.className = options.className.replace("hidden", "");
  } else {
    options.classList.add("hidden");
  }
  
}

  function showImageOptions() {
    let options = document.getElementsByClassName('image_options')[0];

    if (options.classList.contains('hidden')) {
      options.className = options.className.replace("hidden", "");
    } else {
      options.classList.add("hidden");
    }
  }

  setTimeout(window.onload = function() {
    if (findGetParameter('image')) {
      let options = document.getElementsByClassName('image_options')[0];
      options.className = options.className.replace("hidden", "");
    }
  }, 100);

  setTimeout(window.onload = function() {
    if (findGetParameter('video')) {
      let options = document.getElementsByClassName('video_options')[0];
      options.className = options.className.replace("hidden", "");
    }
  }, 100);

  function findGetParameter(parameterName) {
    var result = null,
        tmp = [];
    location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
          tmp = item.split("=");
          if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        });
    return result;
  }

  function adjustWidth(slider) {
    let div = slider.parentElement;
    let sliderValue = slider.value;

    div.style.width = sliderValue + '%';
  }


}

document.addEventListener("turbolinks:load", load(), false);