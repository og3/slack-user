$(function() {

  var body = $(".message_main__body")

// 自動更新機能
  function update() {
    $.ajax(window.location.href, {
      type: 'GET',
      dataType: 'json',
    })
      autoscroll();
  }

// 自動更新呼び出し機能
  $(function() {
    update();
    //関数update()を5000ミリ秒間隔で呼び出す
    setInterval(update, 5000);
  });

  // htmlを作成する機能
  function buildHTML(adddata) {
    // 引数adddataにimageが入っていたら、表示するhtmlを追加する
    if(adddata.image_url){
      var addImage = '<img src="' + adddata.image_url + '">';
    }else{
      var addImage = '';
    }
// 新規に入力された値を入れるhtmlを新規に作る。記法はHTMLで書く。
    var html =
      '<li class="message_main__body__list__item clearfix">'     +
        '<p class="message_main__body__list__item__name">'       +
          adddata.name                                        +
        '</p>'                                                +
        '<p class="message_main__body__list__item__time_stamp">' +
          adddata.datetime                                    +
        '</p>'                                                +
        '<p class="message_main__body__list__item__message">'    +
          adddata.message                                     +
        '</p>'                                                +
        '<p class="message_main__bodyt__list__item__image">'     +
          addImage                                            +
        '</p>'                                                +
      '</li>'
    return html;
  }

// メッセージ送信機能。sendボタンがclickされた時に以下のイベントが行われるようにする。（メッセージ送信後にsendボタンにdisabledがかからないようにするため）
  $('.send-button').click('submit', function(e) {
//フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止める
    e.preventDefault(); 
    sendmessage();

  });

// 画像送信機能。file_fieldがchangeしたら発動。非同期通信の処理を呼び出す。
//     $('#message_image').on('change', function(e){
// //フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止める
//       e.preventDefault(); 
//       sendmessage();
//     });

// 非同期通信の処理
  function sendmessage(){
    // urlの部分を区切って配列にする。
    var url = window.location.href.split("/");
    // 配列の４番目にteam_idが入っているのでそれを取得する。
    var team_id = url[4]
    var channel_id = url[6]
    // $('#new_message')はform_forで自動生成されたidで、すべての入力欄の親要素
    var form = $('#new_message').get(0);
    var formData = new FormData(form);
    $.ajax({
      url: '/teams/' + team_id + '/channels/' + channel_id + '/messages',
      type: 'POST',
      data: formData,
      dataType: 'json', //データをjson形式でPOSTする
      processData: false,
      contentType: false,
    })
    //↓フォームの送信に成功した場合の処理
    .done(function(data) {
      var html = buildHTML(data);
      //ul.message_main__body__listを選択し、上の変数htmlを挿入している
      $('ul.message_main__body__list').append(html); 
      // formに入力された値を空にする
      form.reset();
      autoscroll();
    })
    //↓フォームの送信に失敗した場合の処理
    .fail(function() {
      alert('フォームの送信に失敗しました');
    });
  }

// スクロール機能
  function autoscroll() {
    body.animate({ scrollTop: body[0].scrollHeight}, 'normal')
  };

});
