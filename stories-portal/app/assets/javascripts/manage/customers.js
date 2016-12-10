$(".manager_customers.index").ready(function() {
    $(".clickable").on('click', function() {
        if ($(this).data('target'))
            window.open($(this).data('href'), $(this).data('target'));
        window.location = $(this).data('href');
    });

});