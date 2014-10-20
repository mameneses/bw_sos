$(document).ready(function(){
  $("#new_answer").on("ajax:success", function(e, data){
    $("#answer-list").append(data)
    $('#answer_title').val("")
    $('#answer_content').val("")
  })
})
