document.addEventListener("DOMContentLoaded", function() {
  var elem = document.querySelector('.masonry-grid');
  var msnry = new Masonry( elem, {
    itemSelector: '.masonry-item',
    columnWidth: '.masonry-item',
    percentPosition: true
  });
});