---
---
$(document).ready ->
  #Preloader
  $(window).on "load", -> # makes sure the whole site is loaded
    $("#status").fadeOut # will first fade out the loading animation
    $("#preloader").delay(350).fadeOut("slow") # will fade out the white DIV that covers the website.
    $("body").delay(350).css({"overflow":"visible"})
    #Mobile menu toggle
  if $(".nav-burger").length
    $(".nav-burger").on "click", ->
      menu_id = $(this).attr("data-target")
      $(this).toggleClass("is-active")
      $("#" + menu_id).toggleClass("is-active")
      $('.navbar.is-light').toggleClass('is-dark-mobile')
  #Animate left hamburger icon and open sidebar
  $('.menu-icon-trigger').click (e) ->
    e.preventDefault
    $('.menu-icon-wrapper').toggleClass('open')
    $('.sidebar').toggleClass('is-active')
  #Close sidebar
  $('.sidebar-close').click ->
    $('.sidebar').removeClass('is-active')
    $('.menu-icon-wrapper').removeClass('open')
  #Sidebar menu
  if $('.sidebar').length
    $(".sidebar-menu > li.have-children a").on "click", (i) ->
      i.preventDefault()
      if not $(this).parent.hasClass "active"
        $(".sidebar-menu li ul").slideUp()
        $(this).next().slideToggle()
        $(".sidebar-menu li").removeClass("active")
        $(this).parent().addClass("active")
      else
        $(this).next().slideToggle()
        $(".sidebar-menu li").removeClass("active")
  #Navbar Clone
  if $('#navbar-clone').length
    $(window).scroll -> # this will work when your window scrolled.
      height = $(window).scrollTop() # getting the scrolling height of window
      if height > 50
        $("#navbar-clone").addClass('is-active')
      else
        $("#navbar-clone").removeClass('is-active')

  #Init feather icons
  feather.replace()
  $window = $(window)
  win_height_padded = $window.height() * 1.1
  isTouch = Modernizr.touch
  $window.on('scroll', revealOnScroll)
  revealOnScroll = ->
    scrolled = $window.scrollTop()
    $(".revealOnScroll:not(.animated)").each ->
      $this = $(this)
      offsetTop = $this.offset().top
      if scrolled + win_height_padded > offsetTop
        if $this.data('timeout')
          window.setTimeout ->
            $this.addClass('animated ' + $this.data('animation'))
          ,parseInt($this.data('timeout'), 10)
        else
          $this.addClass('animated ' + $this.data('animation'))
  #Back to Top button behaviour
  pxShow = 600
  scrollSpeed = 500
  $(window).scroll ->
    if($(window).scrollTop() >= pxShow)
      $("#backtotop").addClass('visible')
    else
      $("#backtotop").removeClass('visible')
  $('#backtotop a').on "click", ->
    $('html, body').animate({scrollTop: 0},scrollSpeed)
    return false
  #modals
  $('.modal-trigger').on "click", ->
    modalID = $(this).attr('data-modal')
    $('#' + modalID).addClass('is-active')
    $('.modal-close, .close-modal').on "click", ->
      $(this).closest('.modal').removeClass('is-active')
      #Select all links with hashes
  $('a[href*="#"]').not('[href="#"]').not('[href="#0"]').click (event) -> # Remove links that don't actually link to anything
   if location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname

    # Figure out element to scroll to
    target = $(this.hash)
    target = if target.length then target else $('[name=' + this.hash.slice(1) + ']')
    # Does a scroll target exist?
    if target.length
      # Only prevent default if animation is actually gonna happen
      event.preventDefault()
      $('html, body').animate({scrollTop: target.offset().top}, 550, ->
        # Callback after animation
        # Must change focus!
        $target = $(target)
        $target.focus()
        if $target.is ":focus" # Checking if the target was focused
          return false
        else
          $target.attr('tabindex', '-1') # Adding tabindex for elements not focusable
          $target.focus() # Set focus again
        )
