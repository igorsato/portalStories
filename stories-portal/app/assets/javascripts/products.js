$(".front_products.show, front_products.index").ready(function() {
    var qty = $("#qtd_products");
    var total = 0;
    $(".remove_product").on('click', function() {
        total = parseInt(qty.val());
        total -= 1;
        if (total > 0) {
            qty.val(total);
        }
    });
    $(".add_product").on('click', function() {
        total = parseInt(qty.val());
        var max = qty.attr('max');
        total += 1;
        if (total <= max) {
            qty.val(total);
        }
    });
    $("input[name='shipping']").on('focus', function() {
        $(this).val('');
    });
    $("input[name='shipping']").on('keydown blur', function(e) {
        if (e.target.value.length > 8) {
            $('#btn-shipping').attr('disabled', false);
        }
        if (!$(this).val()) {
            $('#btn-shipping').attr('disabled', true);
        }
    });
    $('#btn-shipping').on('click', function() {
        var shipping = $("input[name='shipping']");
        var qtd_products = $("#qtd_products");
        $("#hidden_shipping").val(shipping.val());
        var product_id = $("#product_id").val();
        var container = $("#truckage");
        $("#truckage > tbody").remove();
        var content = new String();
        if (shipping.val().length > 8) {
            $('#btn-shipping').attr('disabled', true);
            $.ajax({
                url: '/products/xhr_mail_shipping',
                method: 'GET',
                dataType: 'json',
                data: { id: product_id, zipcode: shipping.val(), quantity: qtd_products.val() },
                success: function(data) {
                    var service = JSON.parse(data.service);
                    console.log(service.sedex)
                    var valor_sedex = numeral(service.sedex.valor);
                    var valor_pac = numeral(service.pac.valor);
                    content += '<tbody class="tbody">'
                    content += '<tr><td>' + service.sedex.nome + '</td><td>R$' + valor_sedex.format('0,0.00') + '</td><td>' + service.sedex.prazo_entrega + ' dia(s)</td></tr>';
                    content += '<tr><td>' + service.pac.nome + '</td><td>R$' + valor_pac.format('0,0.00') + '</td><td>' + service.pac.prazo_entrega + ' dia(s)</td></tr>';
                    content += '</tbody>';

                    if (service.sedex.erro !== '0') {
                        content += '<tbody class="tbody"><tr><td class="mdl-cell--alert" colspan="3">' + service.sedex.msg_erro + '</td></tr></tbody>'
                    }
                    container.append(content);
                    container.parent().show();
                }

            });
        }
    });
});