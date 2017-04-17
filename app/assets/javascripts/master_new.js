$(function() {

// 未入力に対するアラートと画面の切り替え
  $('.master_email__headline__button').click('submit', function() {
    var email = $('.master_email__headline__email').val();
    if (email.length == 0) {
      alert("emailを入力してください");
    } else {
      $('.email').fadeOut(0);
      $('.master_header_password').css('background-color', 'white');
      $('.password').fadeIn(900);
    }
  });

// enterでsubmitが押されないようenterを封印
  $("master_password__body__footer__container__button").on("keydown", function(e) {
      if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)) {
          return false;
      } else {
          return true;
      }
  });

});