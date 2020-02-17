function load() {

  let img = document.getElementsByTagName('img')[0];
  let width = img.width;

  if (width > 800) {
    img.width = 800;
  }
}

document.addEventListener('turbolinks:load', load);