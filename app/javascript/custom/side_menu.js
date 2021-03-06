function load() {

  let gen1Links = document.getElementsByClassName('gen1');
  let gen2Links = document.getElementsByClassName('gen2');
  let gen3Links = document.getElementsByClassName('gen3');
  let gen4Links = document.getElementsByClassName('gen4');
  let gen5Links = document.getElementsByClassName('gen5');


  for (let i = 0; i < gen1Links.length; i++) {
    let siblingElement = gen1Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen1Links[i]);
  }

  for (let i = 0; i < gen2Links.length; i++) {
    let siblingElement = gen2Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen2Links[i]);
  }

  for (let i = 0; i < gen3Links.length; i++) {
    let siblingElement = gen3Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen3Links[i]);
  }

  for (let i = 0; i < gen4Links.length; i++) {
    let siblingElement = gen4Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen4Links[i]);
  }

  for (let i = 0; i < gen5Links.length; i++) {
    let siblingElement = gen5Links[i].nextElementSibling;
    siblingElement.style.display = 'none';
    addMenuArrow(gen5Links[i]);
  }

  function addMenuArrow(item) {

    let siblingElement = item.nextElementSibling;
    let childrenCount = siblingElement.childElementCount;
    let rootPages = siblingElement.getElementsByTagName('ul')[0];
   
    let arrowPresent = item.getElementsByClassName('chevron')[0]; 

    if (siblingElement && rootPages) {

      let rootChildrenCount = rootPages.childElementCount;
      if ((childrenCount > 1 || rootChildrenCount > 0) && !arrowPresent) {
        item.innerHTML += "<box-icon class='chevron' size='16px' color='#E8E8E8' name='caret-down'></box-icon>"
      }
    }
  }
  
  function display() {
    let siblingElement = $(this).next();
    siblingElement.slideToggle(300);
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

  for (let i = 0; i < gen5Links.length; i++) {
    gen5Links[i].onclick = display;
  }

  // $('#side_panel').height($(window).height() - $('.header_container').height() - $('#side_background').height())
  $('#side_background').scrollLock();
  $('#side_menu_nav').scrollLock();
  $('.side_panel_container').scrollLock();
  $('.sidebar').scrollLock();

  $('#side_panel').hover(function() {
    $(this).height($(window).height() - $('.header_container').height() - $('#side_background').height())
  }, function() {
    $(this).height(0)
  })


  // Get top position of side_panel. Set event listener for scroll on window.
  // If value of the scroll of the top of the page is greater than the top of the side panel,
  // set it to position fixed so that it stays on the screen.
  var sidePanelTop = $('#side_panel').offset().top;
  $(window).scroll(function() {
    var currentScroll = $(window).scrollTop();
    let headerHeight = $('.header_container').height()
    let currentClientHeight = $(window).height()
    let sideBackground = $('#side_background').height()
    let height = 0
    if (currentScroll >= sidePanelTop) {
      height = currentClientHeight - sideBackground
    } else {
      height = currentClientHeight - headerHeight - sideBackground
    }
  
    $('#side_panel').hover(function() {
      $(this).height(height)
    }, function() {
      $(this).height(0)
    })
    
    if (currentScroll >= sidePanelTop) {
        $('#side_panel').css({
            position: 'fixed',
            top: '0',
            left: '0'
        });
    } else {
        $('#side_panel').css({
          position: 'absolute',
          top: 'unset',
          left: 'unset'
        });
    }
});

}

document.addEventListener('turbolinks:load', load);
