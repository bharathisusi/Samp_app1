var vote = {};
$( document ).ready(function() {
  vote.upDownVote();
  vote.addComment();
});

vote.upDownVote = function() {
  $('[class^=append_answer_], .append_question, .ques-cmt, [class^=append_answer_comment_]').on("click", "[class^=append_question_comment_] [id^=submit_], [id^=submit_]", function() {

    var q_id = $(this).attr("question_id");
    var a_id = $(this).attr("answer_id");
    var c_id = $(this).attr("comment_id");

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
    if (typeof(c_id) != "undefined" ){
      if (typeof(a_id) != "undefined"){
        answer_id = a_id;
        question_id = q_id;
        comment_id = c_id;
        $append = $(".append_answer_comment_"+c_id);

      } else{
        answer_id = null;
        question_id = q_id;
        comment_id = c_id;
        $append = $(".append_question_comment_"+c_id);
      }
    }
    else if(typeof(a_id) != "undefined" ){
      answer_id = a_id;
      question_id = q_id;
      $append = $(".append_answer_"+a_id);
    } else {
      question_id = q_id;
      answer_id = null;
      $append = $(".append_question");
    }
    var hash_value =0
    $.ajax({
      type: "POST",
      url: '/votes/upvote',
      data:{ vote : {current_count :hash_value }, upvote: upvote, downvote: downvote, question_id: q_id, answer_id: a_id, comment_id: c_id },
      success: function(result) {
        if (result.error) {
          toastr.error(result.error);
        }
        else{
          $append.html(result.html);
        }
      }
    });
  });
}


vote.addComment = function() {
  $('.create_comment, .ques-cmt').on("click", "[class^=edit_comment_] [id^=comment_], [id^=comment_]", function() {
    var url_id = $(this).attr("url_id");
    var c_id = $(this).attr("url_comment_id");
    if (typeof(c_id) != "undefined"){
      var edit = c_id+"/edit";
      $append = $(".append_edit_comment_"+c_id);
    } else {
      var edit = "new";
      $append = $(".append_create_comment");
    }
    $.ajax({
      type: "GET",
      url:  "/questions/"+url_id+"/comments/"+edit,
      success: function(result) {
       $append.html(result.html);
       $('#create_comment').addClass("hide");
      }
    });
  });
}
