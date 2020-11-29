$(document).on('turbolinks:load', function() {
    let additions = 0
    let removals = 0

    $('#diff_summary').find('.symbol').each(function () {
        if ($(this).html() === '+') {
            additions++
        } else if ($(this).html() === '-') {
            removals++
        }
    })
    
    $('#diff_report').html(`<p><span class="text-danger">${pluralize(removals)} removed</span> | <span class="text-success">${pluralize(additions)} added</span></p>`)

    function pluralize(count) {
        if (count === 1) {
            result = `${count} item`
        } else {
            result = `${count} items`
        }

        return result
    }

    $('.del').on('click', function () {
    // $('.del').each(function () {
        let string = $(this).children(':first').html()
        let span = '<span class="symbol">-</span>'
        let text = string.substring(span.length, string.length);
        let style = '#fee'
        highlight(text, style)
    })

    $('.ins').on('click', function () {
    // $('.ins').each(function () {
        let string = $(this).children(':first').html()
        let span = '<span class="symbol">+</span>'
        let text = string.substring(span.length, string.length);
        let style = '#dfd'
        console.log(text)
        highlight(text, style)
    })

    // Highlight text in the document
    function highlight(text, style) {
        var page_html = document.getElementById('page').innerHTML;
        var page = document.getElementById('page');
        var draft_html = document.getElementById('draft').innerHTML;
        var draft = document.getElementById('draft');
        text = text.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); //https://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex

        var re = new RegExp(text, 'g');
        var m;

        if (text.length > 0) {
            page.innerHTML = page_html.replace(re, `<span style='background-color:${style};'>$&</span>`);
            draft.innerHTML = draft_html.replace(re, `<span style='background-color:${style};'>$&</span>`);

        } else {
            page.innerHTML = page_html;
            draft.innerHTML = draft_html;
        }
    }

    $('#show_context').on('click', function () {
        if ($(this).html() === 'Show Context') {
            $(this).html('Hide Context')
        } else {
            $(this).html('Show Context')
        }
        $('#diff_summary').toggle(500)
        $('#diff_full').toggle(500)
    })
})