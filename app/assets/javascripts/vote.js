
$( document ).ready(function() {
  $(".append_question").on("click", "#submit_button", function() {
    var q_id = $(this).attr("question_id");
    var a_id = $(this).attr("answer_id");
    var upvote = $(this).attr("upvote")
    var downvote = $(this).attr("downvote")
    var error_class = ".alert-danger"


    if (typeof(upvote) != "undefined"){
      upvote = upvote;
      downvote = null;
    } else {
      downvote = downvote;
      upvote = null;
    }

    if (typeof(a_id) != "undefined"){
      answer_id = a_id;
      question_id = null;
    } else {
      question_id = q_id;
      answer_id = null;
    }
    console.log(q_id);
    console.log(a_id);

    var hash_value =0
    $.ajax({
      type: "POST",
      url: '/votes/upvote',
      data:{ vote : {current_count :hash_value }, upvote: upvote, downvote: downvote, question_id: q_id, answer_id: a_id},
      success: function(result) {
        if (result.error) {
          // var msg = $(error_msg_string).children('span').attr('class')
          var error_msg_string = "<div class='alert fade in alert-danger'><button type='button' class='close' data-dismiss='alert'>×</button><span class='display_msg'>"+result.error+"</span></div>"
          $('.show_error').html(error_msg_string);
          $(error_class).removeClass("hide");
        }
        else{
          $(".append_question").html(result.html)
          $(error_class).addClass("hide");
        }
      }
    });
  });
});
