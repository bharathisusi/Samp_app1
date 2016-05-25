
$( document ).ready(function() {
  $("#submit_button").on("click", function() {
    var q_id = $(this).attr("question_id");
    var hash_value =0
    $.ajax({
      type: "POST",
      url: '/votes/upvote?question_id='+q_id+'',
      data:{ vote : {current_count :hash_value }},
      success: function(result) {
        $("#submit_button").html(result.html)
      }
    });
  });
});
