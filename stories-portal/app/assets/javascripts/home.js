$(function() {
    $('.shipping').mask('00000-000');
    $('.maskcpf').mask('000.000.000-00');
    numeral.language('pt-br');
    $("body").on('blur', '.get_cep, .add_address', function(e) {
        if ($(e.target).val().length > 8) {
            var cep = $(e.target).val().replace(/\-/, '');
            $.getJSON('https://viacep.com.br/ws/' + cep + '/json/?callback=?', function(data) {
                fillAddress(data);
            });
        } else {
            $(e.target).val('')
        }
    });
    var frete_valor = numeral(0);
    $("body").on('click', '.shipping-pac, .shipping-sedex', function(e) {
        // $.ajax({
        //     url: '/carts/postal_code',
        //     type: 'GET',
        //     data: { postal_code_value: $(e.target).data('postal-code-value') },
        //     dataType: 'json',
        //     success: function(d, i) {
        //         console.log(d)
        var valor_frete = numeral($(e.target).data('postal-code-value'));
        var total_cart = numeral($('.total_cart').text());
        // var total = numeral(d.total_cart);
        var total = total_cart.add(valor_frete).subtract(frete_valor);
        var total_money = total.format('$ 0,0.00');
        $('.frete').text(valor_frete.format('$ 0,0.00'));
        $('.total_cart').text(total_money);
        var number = total_money;
        $('#shipping_value').val(valor_frete.format('0,0.00').replace('.', '').replace(',', '.'));
        var name_truckage = ($(e.target).val().replace('shipping-', ''));
        $('#shipping_name').val(name_truckage.toUpperCase());

        //     }
        // });
        createCookie('frete', $(e.target).val());
        frete_valor = numeral($(e.target).data('postal-code-value'));
    });
    $('.shipping-cart').on('click', function() {
        getTruckage();
    });
    $(".front_checkout.index").ready(function() {
        $("input[type='radio'].address_id:checked").each(function(i, e) {
            if ($(e).is(':checked')) {
                $('.get_truckage').val($(e).data('zipcode'));
            }
        });
    });
    $(".address_id").on('click', function(e) {
        $('.get_truckage').val($(e.target).data('zipcode'));
        $('.shipping-cart').trigger('click');
    });
});

$(".front_carts.show").ready(function() {
    if (getCookie('cep')) {
        $('.get_truckage').val(getCookie('cep'));
        $('.shipping-cart').trigger('click');
    };
});

function getTruckage() {
    if (!$('.get_truckage').val()) {
        return false;
    }
    var shipping = $('.get_truckage').val();
    var container = $("#cart-truckage");
    createCookie('cep', shipping);
    $('#shipping_cart').val(shipping);
    $("#cart-truckage > tbody").remove();
    var content = new String();
    $.ajax({
        url: '/shipping',
        data: { shipping: shipping },
        dataType: 'json',
        cache: true,
        success: function(data) {
            var service = JSON.parse(data.service);

            var valor_sedex = numeral(service.sedex.valor);
            var valor_pac = numeral(service.pac.valor);
            content = '<tbody class="tbody">'
            content += '<tr><td><input type="radio" class="shipping-sedex" data-type="1"  data-postal-code-value="' + valor_sedex + '" name="shipping" value="shipping-sedex"> </td><td>' + service.sedex.nome + '</td><td>R$' + valor_sedex.format('0,0.00') + '</td><td>' + service.sedex.prazo_entrega + ' dia(s)</td></tr>';
            content += '<tr><td><input type="radio"  class="shipping-pac" data-type="2" name="shipping"  data-postal-code-value="' + valor_pac + '" value="shipping-pac"> </td><td>' + service.pac.nome + '</td><td>R$' + valor_pac.format('0,0.00') + '</td><td>' + service.pac.prazo_entrega + ' dia(s)</td></tr>';
            content += '</tbody>';
            if (service.sedex.erro !== '0') {
                content += '<tbody class="tbody"><tr><td class="mdl-cell--alert" colspan="4">' + service.sedex.msg_erro + '</td></tr></tbody>'
            }

            container.append(content);
            container.fadeIn('slow', function() {
                $(this).show('slow')
            });
            $('#btn-shipping').attr('disabled', true);
            if (getCookie('frete')) {
                $('.' + getCookie('frete')).trigger('click');
                $("#finalize_buy_button").attr('disabled', false);
            } else {
                if ($(".shipping-sedex").not(":checked") && $(".shipping-pac").not(":checked")) {
                    $(".shipping-pac").attr('checked', true);
                    $(".shipping-pac").trigger('click');
                }
            }

            if (service.sedex.erro === '-3') {
                $("#finalize_buy_button").attr('disabled', true);
            }

        }

    });
}
states = [
    '',
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MS',
    'MT',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
]

function fillAddress(data) {
    if (!("erro" in data)) {
        $('.street_address').parent('div').addClass('is-dirty');
        $('.street_address').val(data.logradouro);
        $('.neighborhood_address').parent('div').addClass('is-dirty');
        $('.neighborhood_address').val(data.bairro);
        $('.city_address').parent('div').addClass('is-dirty');
        $('.city_address').val(data.localidade);
        $('select.state_address option').each(function(i, e) {
            if (states[i] === data.uf) {
                $(e).prop('selected', true);
            }
        });

    }
}

function createCookie(name, value, days) {
    var expires;
    if (Number(days)) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    } else {
        expires = "";
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function getCookie(name) {
    var value = "; " + document.cookie;
    var parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
}

function deleteCookie(name) {
    document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

replaceField = function(value) {
    return value.replace(/^[\D]/gi, '');
}

function isCPF(cpf) {
    if (cpf.length <= 0) return;
    cpf = cpf.replace(/\D/g, '');
    while (cpf.length < 11) cpf = "0" + cpf;
    var expReg = /^0+$|^1+$|^2+$|^3+$|^4+$|^5+$|^6+$|^7+$|^8+$|^9+$/;
    var a = [];
    var b = new Number;
    var c = 11;
    for (i = 0; i < 11; i++) {
        a[i] = cpf.charAt(i);
        if (i < 9) b += (a[i] * --c);
    }
    if ((x = b % 11) < 2) { a[9] = 0 } else { a[9] = 11 - x }
    b = 0;
    c = 11;
    for (y = 0; y < 10; y++) b += (a[y] * c--);
    if ((x = b % 11) < 2) { a[10] = 0; } else { a[10] = 11 - x; }


    if ((cpf.charAt(9) != a[9]) || (cpf.charAt(10) != a[10]) || cpf.match(expReg)) {
        return false;
    }

    return true;

}


$(".front_my_personal_details.index").ready(function() {

    $('#submit_customer').on('click', function(e) {

        $("#error-explanation > ul#error-ul-card").remove();
        error_container = $("#error-explanation");
        ul = $('<ul/>', { class: 'mdl-cell--alert', id: 'error-ul-card' });
        if (!$("#customer_name").val()) {
            $('#customer_name').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um nome.');
            ul.append(li);
        }
        if (!$("#customer_lastname").val()) {
            $('#customer_lastname').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um sobrenome.');
            ul.append(li);
        }

        if (!isCPF($("#customer_cpf").val())) {
            $('#customer_cpf').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um cpf válido.');
            ul.append(li);
        }
        if (ul[0].childNodes.length > 0) {
            error_container.append(ul);
            return false;
        }

    });
});