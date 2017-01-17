$(document).ready(function(){
  $('#slide-index .active').on('click', toggleActive)
})

function toggleActive () {
  var toggleClass = $(this)['0'].name
  var $this = $(this).parents('tr')
  var slideId = $this.data().id
  $.ajax({
    url: '/api/v1/signage/' + slideId,
    method: 'PATCH',
    data: {toggle:  toggleClass}
  })
}
