$(function() {

// 未入力に対するアラートと画面の切り替え
  $('.team_name_button').click('submit', function() {
    var name = $('.team__name__input').val();
    if (name.length == 0) {
      alert("nameを入力してください");
    } else {
      $('.team_name').fadeOut(0);
      $('.team_purpose').fadeIn(900);
    }
  });

// enterでsubmitが押されないようenterを封印
  $("input").on("keydown", function(e) {
      if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)) {
          return false;
      } else {
          return true;
      }
  });

});