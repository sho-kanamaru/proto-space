if(window.File) {
  // ファイルが選択されたとき
  document.addEventListener("DOMContentLoaded", function(){
    $(document).on('turbolinks:load', function () {
      $("input[type=file]").change(function(e) {
        var image = e.target;
        var image_list = image.closest("div");
        var current_image = $(this)[0].previousElementSibling;
        if(current_image != null){
          current_image.remove();
        }
        var fileData = image.files[0];
        console.log(fileData);
        var imgType = fileData.type;

        // 選択されたファイルが画像かどうか確認
        if(!imgType.match(/^image/)) {
          alert('画像を選択してください');
          image.value = '';
          return;
        }

        var reader = new FileReader();
        // ファイル読み取りに失敗したとき
        reader.onerror = function() {
          alert('ファイル読み取りに失敗しました')
          insertBefore('', e.target);
        }
        // ファイル読み取りに成功したとき
        reader.onload = function() {
          var insert = document.createElement("img");
          insert.src = reader.result;
          image_list.prepend(insert);
        }
        // ファイル読み取りを実行
        reader.readAsDataURL(fileData);
      });
    });
  }, false);
}
