const eadappter = {
  init: function() {
    this.header.init();
    this.footer.init();
    this.cropper.init();
    this.animation.init();
    this.search.init();
    this.sort.init();
    this.form.init();
    this.tab.init();
  },
};

eadappter.header = {
  init: function() {
    this.setParams();
    this.checkLogin();
    this.setFlashMsg();
  },
  setParams: function() {
    this.header = $('.header');
    this.siteTitle = $('.header__siteTitle');
    this.navList = $('.header__navList');
  },
  fixHeader: function() {
    const offset = $('html').offset();
    $(window).on('scroll', () => {
      if ($(window).scrollTop() > offset.top + 50){
        if (!this.header.hasClass("header_type_default")){
          this.header.hide();
        }
        this.header.addClass('header_type_default');
        this.siteTitle.addClass('header__siteTitle_type_default');
        this.navList.addClass('header__navList_type_default');
        this.header.fadeIn();
      } else {
        if (this.header.hasClass("header_type_default")) {
          this.header.removeClass('header_type_default');
          this.siteTitle.removeClass('header__siteTitle_type_default');
          this.navList.removeClass('header__navList_type_default');
        }
        this.header.addClass('header_type_fixed');
        this.siteTitle.addClass('header__siteTitle_type_fixed');
        this.navList.addClass('header__navList_type_fixed');
      }
    });
  },
  checkLogin: function() {
    const login = $('#currentUserCheck').val();
    if (login === "true") {
      this.header.addClass('header_type_default');
      this.siteTitle.addClass('header__siteTitle_type_default');
      this.navList.addClass('header__navList_type_default');
      this.siteTitle.addClass('header__siteTitle_state_login');
      this.navList.addClass('header__navList_state_login');
    } else {
      this.siteTitle.addClass('header__siteTitle_state_logout');
      this.navList.addClass('header__navList_state_logout');
      this.checkURI();
    }
  },
  checkURI: function() {
    const signUp = $('.userSignup').html();
    const signIn = $('.userNew').html();
    const adIndex = $('.adIndex').html();
    if (adIndex) {
      this.header.addClass('header_type_default');
      this.siteTitle.addClass('header__siteTitle_type_default');
      this.navList.addClass('header__navList_type_default');
    } else if (signIn || signUp) {
      this.header.css('display', 'none');
    } else {
      this.fixHeader();
    }
  },
  setFlashMsg: function() {
    const notice = $('.header__flashMessage_type_notice');
    const alert = $('.header__flashMessage_type_alert');
    const remove = () => {
      notice.fadeOut().queue(function() {
        $(this).remove();
      });
      alert.fadeOut().queue(function() {
        $(this).remove();
      });
    };
    setTimeout(remove, 2000);
  },
};

eadappter.footer = {
  init: function() {
    this.setParams();
    this.checkURI();
  },
  setParams: function() {
    this.footer = $('.footer');
    this.arw = $('.footer__arw');
    this.title = $('.footer__title');
    this.fnav = $('.footer__fnav');
    this.copy = $('.footer__copy');
  },
  checkURI: function() {
    const signUp = $('.userSignup').html();
    const signIn = $('.userNew').html();
    if (signUp || signIn) {
      this.arw.css('display', 'none');
      this.title.css('display', 'none');
      this.footer.addClass('footer_type_fixed');
      this.fnav.addClass('footer__fnav_type_fixed');
      this.copy.addClass('footer__copy_type_fixed');
    } else {
      this.footer.addClass('footer_type_default');
      this.fnav.addClass('footer__fnav_type_default');
      this.copy.addClass('footer__copy_type_default');
      this.checkLogin();
    }
  },
  checkLogin: function() {
    const login = $('#currentUserCheck').val();
    if (login === "true") {
      this.footer.css('display', 'none');
    }
  },
};

eadappter.cropper = {
  init: function() {
    this.setParams();
    this.setEventListener();
  },
  setParams: function() {
    this.cropper;
    this.croppable = false;
    this.croppedCanvas;
    this.blob;
    this.route = $('#route').val();
    this.id = $('#idParams').val();
    this.action = $('#action').val();
  },
  setEventListener: function() {
    const fileField = $('#upfile');
    const overlay = $('.overlay');
    const selectBtn = $('.select_btn');
    const closeBtn = $('.close_btn');
    const submitBtn = $('#ajaxSubmit');
    fileField.on('change', (e) => {
      const file = e.target.files[0];
      const reader = new FileReader();
      const cropModal = $('.crop_modal');
      if (file.type.indexOf('image') < 0) {
        alert('画像を指定してください。');
        fileField.val("");
        return false;
      };
      reader.onload = (e) => {
        overlay.fadeIn();
        cropModal.append($('<img>').attr({
          src: e.target.result,
          class: "preview",
          id: "crop_img",
          title: file.name
        }));
        this.initCrop();
      };
      reader.readAsDataURL(file);
    });
    selectBtn.on('click', () => {
      this.cropping();
      overlay.fadeOut();
      fileField.val("");
      $('#crop_img').remove();
      $('.cropper-container').remove();
    });
    closeBtn.on('click', () => {
      overlay.fadeOut();
      fileField.val("");
      $('#crop_img').remove();
      $('.cropper-container').remove();
    });
    submitBtn.on('click', () => {
      this.blobing();
    });
  },
  initCrop: function() {
    if (this.route === 'users') {
      this.ratio = 1;
      this.cropWidth = 280;
      this.cropHeight = 280;
    } else if (this.route === 'advertisements') {
      this.ratio = 4/3;
      this.cropWidth = 360;
      this.cropHeight = 270;
    }
    this.cropper = new Cropper(crop_img, {
      aspectRatio: this.ratio,
      minCropBoxWidth: this.cropWidth,
      minCropBoxHeight: this.cropHeight,
      dragMode: 'move',
      restore: false,
      guides: false,
      center: false,
      highlight: false,
      cropBoxMovable: false,
      cropBoxResizable: false,
      ready: function() {
        this.croppable = true;
      }
    });
  },
  cropping: function() {
    const croppedImage = document.createElement('img');
    this.croppable = true;
    if (!this.croppable) {
      alert('トリミングする画像が設定されていません。');
      return false;
    }
    this.croppedCanvas = this.cropper.getCroppedCanvas({
      width: this.cropWidth,
      height: this.cropHeight,
    });
    croppedImage.src = this.croppedCanvas.toDataURL();
    img_field.innerHTML = '';
    img_field.appendChild(croppedImage);
  },
  blobing: function() {
    if (this.croppedCanvas && this.croppedCanvas.toBlob){
      this.croppedCanvas.toBlob((b) => {
        this.blob = b;
        this.sending();
      });
    }else if(this.croppedCanvas && this.croppedCanvas.msToBlob){
      this.blob = this.croppedCanvas.msToBlob();
      this.sending();
    }else{
      this.blob = null;
      this.sending();
    };
  },
  sending: function() {
    const formData = new FormData();
    let url;
    let type;
    $.ajaxPrefilter(function(options, originalOptions, jqXHR){
      let token;
      if (!options.crossDomain){
        token = $('meta[name="csrf-token"]').attr('content');

        if (token){
          return jqXHR.setRequestHeader('X-CSRF-Token', token);
        };
      };
    });
    if (this.route === "users"){
      this.usersVal(formData);
    }else if (this.route === "advertisements"){
      this.advertisementsVal(formData);
    }
    if (this.action === "new") {
      url = '/' + this.route;
      type = 'post';
    } else if (this.action === "edit") {
      url = '/' + this.route + '/' + this.id;
      type = 'patch';
    }
    $.ajax({
      url: url,
      type: type,
      data: formData,
      datatype: 'json',
      processData: false,
      contentType: false,
    });
  },
  usersVal: function(formData) {
    const name = $('#name').val();
    const email = $('#email').val();
    const twitter = $('#twitter').val();
    const facebook = $('#facebook').val();
    const content = $('#content').val();
    const want_to_advertise = $(':radio[name="want_to_advertise"]:checked').val();
    const want_to_be_advertised = $(':radio[name="want_to_be_advertised"]:checked').val();
    if (this.blob != null){
      formData.append('icon', this.blob);
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
  },
  advertisementsVal: function(formData) {
    const title = $('#title').val();
    const app_url = $('#url').val();
    const hash_01 = $('#hash_01').val();
    const hash_02 = $('#hash_02').val();
    const hash_03 = $('#hash_03').val();
    const hash_04 = $('#hash_04').val();
    const content = $('#content').val();
    const func = $('#function').val();
    const target = $('#target').val();
    const condition = $('#condition').val();
    const fee = $('#fee').val();
    const active = $(':radio[name="active"]:checked').val();
    const app_category = $(':radio[name="app_category"]:checked').val();
    const target_sex = $(':radio[name="target_sex"]:checked').val();
    const target_age = $(':radio[name="target_age"]:checked').val();
    const request_follower = $(':radio[name="request_follower"]:checked').val();
    if (this.blob != null){
      formData.append('image', this.blob);
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
    if (active != null){
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
  },
};

eadappter.animation = {
  init: function() {
    this.setParams();
    this.setScroll();
    this.setSnavSlide();
  },
  setParams: function() {
    this.anchor = $('a[href^="#"]');
  },
  setScroll: function() {
    this.anchor.on('click', function() {
      const speed = 600;
      const href = $(this).attr("href");
      const target = $(href === "#" || href === "" ? 'html' : href);
      const position = target.offset().top;
      $('body,html').animate({scrollTop:position}, speed, 'swing');
    });
  },
  setSnavSlide: function() {
    const snav = $('#snav');
    const openBtn = $('.header__snavBtn');
    const closeBtn = $('.snav__closeBtn');
    openBtn.on('click', () => {
      snav.addClass('open');
    });
    closeBtn.on('click', () => snav.removeClass('open'));
  },
};

eadappter.search = {
  init: function() {
    this.setParams();
    this.setDetailSearch();
  },
  setParams: function() {
    this.detailSearchBtn = $('#detailSearchBtn');
    this.searchAreaInput = $('#searchAreaInput');
    this.searchAreaBtn = $('#searchAreabtn');
    this.detailSearch = $('#detailSearch');
    this.iconArw = $('#detailSearchBtn > i');
  },
  setDetailSearch: function() {
    this.detailSearchBtn.on('click', () => {
      if (this.detailSearchBtn.attr('class').indexOf('opening') !== -1) {
        this.detailSearch.toggle(500);
        this.detailSearchBtn.removeClass('adIndex-leftSide-searchArea__searchMore_type_opening');
        this.detailSearchBtn.addClass('adIndex-leftSide-searchArea__searchMore_type_opened');
        this.iconArw.removeClass('fa-caret-down').addClass('fa-caret-up');
        this.searchAreaInput.hide();
        this.searchAreaBtn.hide();
      } else {
        this.detailSearch.toggle(500);
        this.detailSearchBtn.removeClass('adIndex-leftSide-searchArea__searchMore_type_opened');
        this.detailSearchBtn.addClass('adIndex-leftSide-searchArea__searchMore_type_opening');
        this.iconArw.removeClass('fa-caret-up').addClass('fa-caret-down');
        this.searchAreaInput.fadeIn();
        this.searchAreaBtn.fadeIn();
      }
    });
  },
};

eadappter.sort = {
  init: function() {
    this.setParams();
    this.setNewSort();
    this.setPopularSort();
    this.setComNumSort();
  },
  setParams: function() {
    this.newSortBtn = $('#sortNew');
    this.popularSortBtn = $('#sortPopular');
    this.comNumSortBtn = $('#sortComNum');
  },
  setNewSort: function() {
    this.newSortBtn.on('click', function() {
      $('#adIndexSort').children().removeClass('clicked');
      $(this).addClass('clicked');
    });
  },
  setPopularSort: function() {
    this.popularSortBtn.on('click', function() {
      $('#adIndexSort').children().removeClass('clicked');
      $(this).addClass('clicked');
    });
  },
  setComNumSort: function() {
    this.comNumSortBtn.on('click', function() {
      $('#adIndexSort').children().removeClass('clicked');
      $(this).addClass('clicked');
    });
  },
};

eadappter.form = {
  init: function() {
    this.setParams();
    this.setTextarea();
  },
  setParams: function() {
    this.textarea = $('textarea');
  },
  setTextarea: function() {
    this.textarea.on('input', function() {
      const lines = ($(this).val() + '\n').match(/\n/g).length;
      const lineHeight = parseInt($(this).css('lineHeight'));
      $(this).height(lineHeight * lines);
    });
  },
};

eadappter.tab = {
  init: function() {
    this.setParams();
    this.setTabs();
  },
  setParams: function() {
    const tabContent = $('#tab_content');
  },
  setTabs: function() {
    $('#tabList').children().on('click', function() {
      $('#tabList').children().removeClass('open');
      $(this).addClass('open');
      if ($(this).hasClass('js-ad')){
        tabContent.html("<%= render 'posted_ad' %>");
      } else if ($(this).hasClass('js-liked')){
        tabContent.html("<%= render 'liked' %>");
      } else if ($(this).hasClass('js-following')){
        tabContent.html("<%= render 'following' %>");
      } else if ($(this).hasClass('js-followed')){
        tabContent.html("<%= render 'followed' %>");
      };
    });
  },
};

$(() => {
  'use strict';
  eadappter.init();
});
