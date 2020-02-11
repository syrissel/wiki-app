function load() {

  let gen1Links = document.getElementsByClassName('gen1');
  let gen2Links = document.getElementsByClassName('gen2');
  let gen3Links = document.getElementsByClassName('gen3');
  let gen4Links = document.getElementsByClassName('gen4');


  for (let i = 0; i < gen1Links.length; i++) {
    let siblingElement = gen1Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen1Links[i]);
  }

  for (let i = 0; i < gen2Links.length; i++) {
    let siblingElement = gen2Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow;
  }

  for (let i = 0; i < gen3Links.length; i++) {
    let siblingElement = gen3Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow;
  }

  for (let i = 0; i < gen4Links.length; i++) {
    let siblingElement = gen4Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow;
  }

  function addMenuArrow(item) {

    let siblingElement = item.nextElementSibling;
    let childrenCount = siblingElement.childElementCount;
  
    if (childrenCount > 1) {
      item.innerHTML += "<box-icon size='16px' name='chevron-down'></box-icon>"
    }
  }
  
  function display() {
    
    // var children = this.children;
  
    // for (var i = 0; i < children.length; i++) {
    //   var child = children[i];
  
    //   if (child.style.display === "none") {
    //     child.style.display = "block";
    //   } else {
    //     child.style.display = "none";
    //   }
      
    // }
  
    let siblingElement = this.nextElementSibling;
  
    if (siblingElement.style.display === 'none') {
      siblingElement.style.display = 'block';
    } else {
      siblingElement.style.display = 'none';
    }
  
  }

  for (let i = 0; i < gen1Links.length; i++) {
    gen1Links[i].onclick = display;
  }

  for (let i = 0; i < gen2Links.length; i++) {
    gen2Links[i].onclick = display;
  }

  for (let i = 0; i < gen3Links.length; i++) {
    gen3Links[i].onclick = display;
  }

  for (let i = 0; i < gen4Links.length; i++) {
    gen4Links[i].onclick = display;
  }

// Mimicking jquery.
// var $ = function (selector) {
//   return document.querySelector(selector);
// };


// window.onload = function() {

// 	var links = $('#root_categories').getElementsByTagName('li');

// 	for (var i = 0; i < links.length; i++) {
//   	var link = links[i];
//   	link.child.style.display = "none";
// 	}

// 	var children = this.children;

// 	for (var i = 0; i < children.length; i++) {
// 		var child = children[i];
    
// 		child.style.display = "none";
    
// 	}
// }

// var links = $('#root_categories').getElementsByTagName('li');

// For each <li> inside #links
// for (var i = 0; i < links.length; i++) {
//   var link = links[i];
//   link.onclick = display;
// }
}

//document.addEventListener("DOMContentLoaded", load, false);
document.addEventListener('turbolinks:load', load);