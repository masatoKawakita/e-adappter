// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery/dist/jquery.js
//= require_tree .

$(function(){
  $('a[href^="#"]').click(function() {
    var speed = 600;
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $('body,html').animate({scrollTop:position}, speed, 'swing');
    return false;
  });
});

$(function(){
  setTimeout(flashMsg, 2000);

  function flashMsg(){
    $('.notice').fadeOut();
    $('.alert').fadeOut();
  }
});

$(function(){
  $('#menu_link').click(function(){
    $('.icon_link_tab').addClass('open');
  });
  $('.close_btn').click(function(){
    $('.icon_link_tab').removeClass('open');
  });
});

$(function(){
  $('.tab_list').children().click(function(){
    $('.tab_list').children().removeClass('open')
    $(this).addClass('open');
    if ($(this).hasClass('ad')){
      $('#tab_content').html("<%= render 'posted_ad' %>");
    }else if ($(this).hasClass('liked')){
      $('#tab_content').html("<%= render 'liked' %>");
    }else if ($(this).hasClass('following')){
      $('#tab_content').html("<%= render 'following' %>");
    }else if ($(this).hasClass('followed')){
      $('#tab_content').html("<%= render 'followed' %>");
    };
  });
});

$(function(){
  $('#sortNew').click(function(){
    $('.sort_list').children().removeClass('clicked');
    $(this).addClass('clicked');
  });
  $('#sortPopular').click(function(){
    $('.sort_list').children().removeClass('clicked');
    $(this).addClass('clicked');
  });
});

$(function(){
  $fileField = $('#upfile')
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field");

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "100%",
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

$(function(){
  $('#search_more_open').click(function() {
    $('.search_more').toggle(500);
    $(this).hide();
    $('.top_search_field').hide();
    $('.top_search_btn').hide();
    $('#search_more_opened').fadeIn();
  });

  $('#search_more_opened').click(function() {
    $('.search_more').toggle(500);
    $(this).hide();
    $('.top_search_field').fadeIn();
    $('.top_search_btn').fadeIn();
    $('#search_more_open').fadeIn();
  });
});

$(function(){
  var cropper;
  var croppable = false;
  function initIconCrop(){
    cropper = new Cropper(crop_img, {
      dragMode: 'move',
      aspectRatio: 1,
      restore: false,
      guides: false,
      center: false,
      highlight: false,
      cropBoxMovable: false,
      cropBoxResizable: false,
      minCropBoxWidth: 280,
      minCropBoxHeight: 280,
      ready: function(){
        croppable = true;
      }
    });
  }

  function initImageCrop(){
    cropper = new Cropper(crop_img, {
      dragMode: 'move',
      aspectRatio: 4 / 3,
      restore: false,
      guides: false,
      center: false,
      highlight: false,
      cropBoxMovable: false,
      cropBoxResizable: false,
      minCropBoxWidth: 360,
      minCropBoxHeight: 270,
      ready: function(){
        croppable = true;
      }
    });
  }

  var croppedCanvas;
  function iconCropping(){
    if (!croppable) {
      alert('トリミングする画像が設定されていません。');
      return false;
    }
    croppedCanvas = cropper.getCroppedCanvas({
      width: 280,
      height: 280,
    });
    var croppedImage = document.createElement('img');
    croppedImage.src = croppedCanvas.toDataURL();
    img_field.innerHTML = '';
    img_field.appendChild(croppedImage);
  };

  function imageCropping(){
    if (!croppable) {
      alert('トリミングする画像が設定されていません。');
      return false;
    }
    croppedCanvas = cropper.getCroppedCanvas({
      width: 360,
      height: 270,
    });
    var croppedImage = document.createElement('img');
    croppedImage.src = croppedCanvas.toDataURL();
    img_field.innerHTML = '';
    img_field.appendChild(croppedImage);
  };

  var blob;
  function blobing(){
    if (croppedCanvas && croppedCanvas.toBlob){
      croppedCanvas.toBlob(function(b){
        blob = b;
        sending();
      });
    }else if(croppedCanvas && croppedCanvas.msToBlob){
      blob = croppedCanvas.msToBlob();
      sending();
    }else{
      blob = null;
      sending();
    };
  };

  function sending(){
    var formData = new FormData();
    const route = $('#route').val();
    const id = $('#idParams').val();
    const action = $('#action').val();

    if (route == "users"){
      usersVal(formData);
    }else if (route == "advertisements"){
      advertisementsVal(formData);
    }

    if (action == "new"){
      $.ajax({
        url: '/' + route,
        type: 'post',
        data: formData,
        processData: false,
        contentType: false,
      });
    }else if (action == "edit"){
      $.ajax({
        url: '/' + route + '/' + id,
        type: 'patch',
        data: formData,
        processData: false,
        contentType: false,
      });
    }
  };

  function usersVal(formData){
    name = $('#name').val();
    email = $('#email').val();
    twitter = $('#twitter').val();
    facebook = $('#facebook').val();
    content = $('#content').val();
    want_to_advertise = $(':radio[name="want_to_advertise"]:checked').val();
    want_to_be_advertised = $(':radio[name="want_to_be_advertised"]:checked').val();

    if (blob != null){
      formData.append('icon', blob);
    }
    formData.append('name', name);
    formData.append('email', email);
    formData.append('twitter', twitter);
    formData.append('facebook', facebook);
    formData.append('content', content);
    if (want_to_advertise != null){
      formData.append('want_to_advertise', want_to_advertise);
    }
    if (want_to_be_advertised != null){
      formData.append('want_to_be_advertised', want_to_be_advertised);
    }
    return formData
  }

  function advertisementsVal(formData){
    title = $('#title').val();
    app_url = $('#url').val();
    hash_01 = $('#hash_01').val();
    hash_02 = $('#hash_02').val();
    hash_03 = $('#hash_03').val();
    hash_04 = $('#hash_04').val();
    content = $('#content').val();
    func = $('#function').val();
    target = $('#target').val();
    condition = $('#condition').val();
    fee = $('#fee').val();
    active = $(':radio[name="active"]:checked').val();
    app_category = $(':radio[name="app_category"]:checked').val();
    target_sex = $(':radio[name="target_sex"]:checked').val();
    target_age = $(':radio[name="target_age"]:checked').val();
    request_follower = $(':radio[name="request_follower"]:checked').val();

    if (blob != null){
      formData.append('image', blob);
    }
    formData.append('title', title);
    formData.append('app_url', app_url);
    formData.append('hash_01', hash_01);
    formData.append('hash_02', hash_02);
    formData.append('hash_03', hash_03);
    formData.append('hash_04', hash_04);
    formData.append('content', content);
    formData.append('about_function', func);
    formData.append('about_target', target);
    formData.append('about_condition', condition);
    formData.append('about_fee', fee);
    if (app_category != null){
      formData.append('active', active);
    }
    if (app_category != null){
      formData.append('app_category', app_category);
    }
    if (target_sex != null){
      formData.append('target_sex', target_sex);
    }
    if (target_age != null){
      formData.append('target_age', target_age);
    }
    if (request_follower != null){
      formData.append('request_follower', request_follower);
    }
    return formData
  }

  $('#upicon').on('change', function(e){
    file = e.target.files[0];
    reader = new FileReader();

    if(file.type.indexOf('image') < 0){
      return false;
    };

    reader.onload = (function(e){
      $('.overlay').fadeIn();
      $('.crop_modal').append($('<img>').attr({
        src: e.target.result,
        height: "100%",
        class: "preview",
        id: "crop_img",
        title: file.name
      }));
      initIconCrop();
    });
    reader.readAsDataURL(file);
  });

  $('#upfile').on('change', function(e) {
    file = e.target.files[0];
    reader = new FileReader();

    if(file.type.indexOf('image') < 0){
      return false;
    };

    reader.onload = (function(e){
      $('.overlay').fadeIn();
      $('.crop_modal').append($('<img>').attr({
        src: e.target.result,
        width: "100%",
        class: "preview",
        id: "crop_img",
        title: file.name
      }));
      initImageCrop();
    });
    reader.readAsDataURL(file);
  });

  $('.select_icon_btn').on('click', function(){
    iconCropping();
    $('.overlay').fadeOut();
    $('#crop_img').remove();
    $('.cropper-container').remove();
  });

  $('.select_image_btn').on('click', function(){
    imageCropping();
    $('.overlay').fadeOut();
    $('#crop_img').remove();
    $('.cropper-container').remove();
  });

  $('.close_btn').on('click', function(){
    $('.overlay').fadeOut();
    $('#crop_img').remove();
    $('.cropper-container').remove();
  });

  $('.submit_btn').on('click', function(){
    blobing();
  });
});
