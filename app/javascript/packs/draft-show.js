$(document).on('turbolinks:load', function() {
    let additions = 0
    let removals = 0

    $('.symbol').each(function () {
        if ($(this).html() === '+') {
            additions++
        } else if ($(this).html() === '-') {
            removals++
        }
    })

    $('#diff_report').html(`<ul><li>${pluralize(removals)} removed.</li><li>${pluralize(additions)} added.</li></ul>`)

    function pluralize(count) {
        if (count === 1) {
            result = `${count} item`
        } else {
            result = `${count} items`
        }

        return result
    }
})