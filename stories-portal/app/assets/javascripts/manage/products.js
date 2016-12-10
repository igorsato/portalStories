$(".manager_products.new, .manager_products.edit, .manager_products.update, .manager_products.create").ready(function(){
  $('.editor').froalaEditor({
  	language: 'pt_br'
  });

		if($('body').hasClass('edit')){
			$('#get-sku').attr('disabled', true);
			$('#get-sku').hide();
		}
  
  //categorias
  $("#categories_has_products").multiSelect();
  $("#pictures_media_add").fileupload({
      url: '/manage/products/gallery_change/',
      formData: {id: $("#pictures_media_add").data('product')}
  });
  $('.pictures_media_remove').on('click', function(e){
      $.ajax({
        method: 'POST',
        url: '/manage/products/gallery_change/',
        data: {id: $(e.target).data('product'), media: $(e.target).data('media')}
      });
  });
//   document.getElementById('product_pictures_media').addEventListener('change', handlerFiles);
//   function handlerFiles(){
//       if(this.files.length > 4){
//           alert("Você somente poderá utilizar 4 Imagens.");
//           this.files.pop();
//           return false;
//       }
//       return true;
//   }
  //SKU DO PRODUTO	
	$('form').on('click', '#get-sku', function(event){
    event.preventDefault();
    $(this).parent().prev().find('input[type="text"]').parent().addClass("is-dirty");
    var text = "";
    var possible = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

    for( var i=0; i < 9; i++ ) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    $(this).parent().prev().find('input[type="text"]').val(text);
	});  
});