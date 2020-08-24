/**
 * 
 * Author: Steph Mireault
 * Date:   August 24, 2020
 * License: MIT
 */
(function (factory) {
    /* Global define */
    if (typeof define === 'function' && define.amd) {
      // AMD. Register as an anonymous module.
      define(['jquery'], factory);
    } else if (typeof module === 'object' && module.exports) {
      // Node/CommonJS
      module.exports = factory(require('jquery'));
    } else {
      // Browser globals
      factory(window.jQuery);
    }
  }(function ($) {
  /**
   * @class plugin.examplePlugin
   *
   * example Plugin
  */
  // Extends plugins for adding hello.
    //  - plugin is external module for customizing.
    $.extend($.summernote.plugins, {
      /**
       * @param {Object} context - context object has status of editor.
       */
      'tableOfContents': function(context) {
        var self = this;
  
        // ui has renders to build ui elements.
        //  - you can create a button with `ui.button`
        var ui = $.summernote.ui;
        var $note    = context.layoutInfo.note;
        //var $code =   $note.summernote('code');
        var $editor  = context.layoutInfo.editor;
        var $editable = context.layoutInfo.editable;
        var $toolbar = context.layoutInfo.toolbar;
        var options  = context.options;
        var lang     = options.langInfo;
        // add tableofcontent button
        context.memo('button.tableOfContents', function() {
          // create button
          var button = ui.button({
            contents: '<i class="fa fa-list-alt" aria-hidden="true"></i>',
            tooltip: 'Table of contents',
            click: function() {
              var h1 = $editable.find('h1, h2, h3, h4');
              var hList= "<h5>Table of Contents</h5><ul id='table_of_contents_list' style='list-style-type:lower-roman;'>";
              var node = document.createElement('div');
              var br = document.createElement('br')
  
              for (var i = 0; i < h1.length; i++)
              {
                if ($.trim($(h1[i]).text()) != "")
                {

                    $(h1[i]).attr("id","title_" + i);
                    hList += "<li><a href='#title_"+ i + "'>" + $(h1[i]).text() + "</a></li>";	
                    
                }
              }
              const range = $.summernote.range;
              const rng = range.create($note, 0, $note, 0)

              hList += "</ul>";
              node.innerHTML = hList;
              node.setAttribute('id', 'table_of_contents')
              node.setAttribute('class', 'border')
              node.setAttribute('style', 'width:18rem; padding:1rem; float: right, margin: 10px;')
              node.setAttribute('contenteditable', 'false')
              node.addEventListener('click', function () {
                  if ($(this).css('float') == 'left') {
                    $(this).css('float', 'right')
                  } else {
                    $(this).css('float', 'left')
                  }
              })

              $note.summernote('editor.setLastRange', rng.collapse(true))
              console.log(rng.collapse(true))
              $note.summernote('insertNode', node);
              $note.summernote('editor.focus')
              $note.summernote('insertHTML', '<br/>')
              $note.summernote('insertText', ' ')
          }});
  
          // create jQuery object from button instance.
          return button.render();
        });
  
        // This method will be called when editor is initialized by $('..').summernote();
        // You can create elements for plugin
        this.initialize = function() {
          /*this.$panel = $('<div class="hello-panel"/>').css({
            position: 'absolute',
            width: 100,
            height: 100,
            left: '50%',
            top: '50%',
            background: 'red'
          }).hide();
  
          this.$panel.appendTo('body');*/
        };
  
        // This methods will be called when editor is destroyed by $('..').summernote('destroy');
        // You should remove elements on `initialize`.
        this.destroy = function() {
         /* this.$panel.remove();
          this.$panel = null;*/
        };
      }
    });
  }));