$(document).ready(function(){
  $('#slide-index .active').on('click', toggleActive)
})

function toggleActive () {
  var $this = $(this).parents('tr')
  var slideId = $this.data().id
  $.ajax({
    url: '/api/v1/signage/' + slideId,
    method: 'PATCH',
    data: {active:  'checked'}
  })
}
