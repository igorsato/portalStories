$(".front_carts.show").ready(function() {
    var total = 0;
    $(".remove_product").on('click', function(e) {
        var name = $(this).attr('name').split('del_');
        var qty = $("#qtd_products_" + name[1]);
        total = parseInt(qty.val());
        total -= 1;
        if (total >= 0) {
            qty.val(total);
        }
    });
    $(".add_product").on('click', function(e) {
        var name = $(this).attr('name').split('add_')
        var qty = $("#qtd_products_" + name[1]);
        var max = qty.attr('max')
        total = parseInt(qty.val());
        total += 1;
        if (total <= max) {
            qty.val(total);
        }
    });
});