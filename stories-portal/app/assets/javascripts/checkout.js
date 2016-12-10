$('.front_checkout.index').ready(function() {
    var radios = $(".radio_addresses input[type='radio']");
    if (!$("#pagSeguro").is(':checked')) {
        $('.payment_method').hide();
        $("#pagSeguro").attr('checked', true);
    }
    $("form").on('click', ' #pagSeguro', function() {
        $('.payment_method').hide();
    });
    $("form").on('click', "#creditCard", function() {
        $('.payment_method').show();
    });
    $('.checkout-cart').on('blur', function() {
        getTruckage();
    });
    if (getCookie('cep')) {
        $('.get_truckage').val(getCookie('cep'));
        $('.checkout-cart').trigger('blur');
    };
    radios.each(function() {
        if (this.checked) {}
    });
    $(document).on('click', '#finalize_buy_button', function(e) {
        $("#error-explanation > ul#error-ul-card").remove();
        error_container = $("#error-explanation");
        ul = $('<ul/>', { class: 'mdl-cell--alert', id: 'error-ul-card' });

        $('#customer_cpf').css('background-color', '#fff');
        $('.alias_address').css('background-color', '#fff');
        $('.street_address').css('background-color', '#fff');
        $('.number_address').css('background-color', '#fff');
        $('.city_address').css('background-color', '#fff');
        $('.neighborhood_address').css('background-color', '#fff');
        $('.state_address').css('background-color', '#fff');
        if ($('#creditCard').is(':checked')) {
            $('#numberCard').css('background-color', '#fff');
            $('#nameCard').css('background-color', '#fff');
            $('#secureCode').css('background-color', '#fff');
            $('#myFlag').css('background-color', '#fff');
            $('#monthValidate').css('background-color', '#fff');
            $('#yearValidate').css('background-color', '#fff');
            if (!$('#numberCard').val()) {
                $('#numberCard').css('background-color', '#F2DEDE');
                li = $('<li/>').text('Preencher um número de cartão.');
                ul.append(li);
            } else if ($('#numberCard').val().length < 14) {
                $('#numberCard').css('background-color', '#F2DEDE');
                li = $('<li/>').text('Preencher um número de cartão correto.');
                ul.append(li);
            }
            if (!$('#nameCard').val()) {
                $('#nameCard').css('background-color', '#F2DEDE');
                li = $('<li/>').text('Preencher com um nome de cartão.');
                ul.append(li);
            }
            if (!$('#secureCode').val()) {
                $('#secureCode').css('background-color', '#F2DEDE');
                li = $('<li/>').text('Preencher com um código de segurança.');
                ul.append(li);
            } else if ($('#secureCode').val().length > 4) {
                $('#nameCard').css('background-color', '#F2DEDE');
                li = $('<li/>').text('Preencher com um código de segurança correto.');
                ul.append(li);
            }
            if ($('#myFlag').prop('selectedIndex') === 0) {
                $('#myFlag').css('background-color', '#F2DEDE');
                li = $('<li/>').text('escolher uma bandeira.');
                ul.append(li);
            }
            if ($('#monthValidate').prop('selectedIndex') === 0) {
                $('#monthValidate').css('background-color', '#F2DEDE');
                li = $('<li/>').text('escolher um mês de validade.');
                ul.append(li);
            }
            if ($('#yearValidate').prop('selectedIndex') === 0) {
                $('#yearValidate').css('background-color', '#F2DEDE');
                li = $('<li/>').text('escolher um ano de validade.');
                ul.append(li);
            }

        }

        if (!isCPF($("#customer_cpf").val())) {
            $('#customer_cpf').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um cpf válido.');
            ul.append(li);
        }
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

        if ($('.alias_address').val() == '') {
            $('.alias_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um apelido.');
            ul.append(li);
        }
        if ($('.street_address').val() == '') {
            $('.street_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um logradouro.');
            ul.append(li);
        }
        if ($('.neighborhood_address').val() == '') {
            $('.neighborhood_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um bairro.');
            ul.append(li);
        }
        if ($('.number_address').val() == '') {
            $('.number_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um número.');
            ul.append(li);
        }
        if ($('.city_address').val() == '') {
            $('.city_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com uma cidade.');
            ul.append(li);
        }
        if ($('.state_address').prop('selectedIndex') == '') {
            $('.state_address').css('background-color', '#F2DEDE');
            li = $('<li/>').text('Preencher com um estado.');
            ul.append(li);
        }
        if ($('td.frete').text() == '' || $('td.frete').text() == 'Escolha um frete') {
            li = $('<li/>').text('Escolha um endereço de entrega.');
            $('td.frete > em').remove();
            $('td.frete').append('<em style="font-size:.8em;">Escolha um frete</em>').css('background-color', '#F2DEDE');
            ul.append(li);
        }


        if (ul[0].childNodes.length > 0) {
            error_container.append(ul);
            return false;
        }
    });
});