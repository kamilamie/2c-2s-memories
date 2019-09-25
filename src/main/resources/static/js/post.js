function like(event) {
    var postId = event.currentTarget.dataset.postId;
    var likesAmount = document.getElementById("likes" + postId);
    $.ajax({
        url: "/ajax/like",
        type: "post",
        data: {
            "postId": postId
        },
        success: function (msg) {
            if (msg === true) {
                likesAmount.innerHTML = +likesAmount.innerHTML + 1;
                document.getElementById("likesHeart" + postId).className = "fa fa-heart";
            } else if (msg === false) {
                likesAmount.innerHTML = +likesAmount.innerHTML - 1;
                document.getElementById("likesHeart" + postId).className = "fa fa-heart-o";
            }
        },
        error: function (msg) {
            alert("error");
        }
    });
}

function deletePost(event) {
    var id = event.target.dataset.postId;
    var post = document.getElementById("post" + id);
    var postModal = document.getElementById("postModal" + id);
    $.ajax({
        url: "/ajax/deletePost",
        type: "post",
        data: {
            "id": id
        },
        success: function (msg) {
            $('#postModal' + id).modal('hide');
            post.remove();
            postModal.remove();

        },
        error: function (msg) {
            alert("error");
        }
    });
}

function deleteComment(event) {
    var id = event.target.dataset.commentId;
    var comment = document.getElementById("comment" + id);
    $.ajax({
        url: "/ajax/deleteComment",
        type: "type",
        method: "post",
        data: {
            "commentId": id
        },
        success: function (msg) {
            comment.remove();
        },
        error: function (msg) {
            alert('error');
        }
    })
}

function addComment(event) {
    var id = event.target.dataset.postId;
    var commentInput = document.getElementById("commentinput" + id);
    if (commentInput.value.trim() === "") return;
    $.ajax({
        url: "/ajax/addComment",
        method: "post",
        data: {
            "postId": +id,
            "text": commentInput.value
        },
        success: function (comment) {
            var noComments = document.getElementById('noComments' + id);
            if (noComments != null) noComments.remove();
            var commentsList = document.getElementById("comments" + id);
            var dateInDays = new Date(comment.date);
            var date = ('0' + dateInDays.getDate()).slice(-2) + "."
                + ('0' + (1 + +dateInDays.getMonth())).slice(-2) + "."
                + dateInDays.getUTCFullYear() + " "
                + dateInDays.getHours() + ":" +
                +dateInDays.getMinutes() + ":" +
                +dateInDays.getSeconds();

            var commentElement = document.createElement("div");
            commentElement.id = "comment" + comment.id;
            commentElement.className = "list-group-item flex-column align-items-start";
            commentElement.innerHTML = "<div class=\"d-flex w-100 justify-content-between\">\n" +
                "                                                                <p class=\"mb-1\"><a\n" +
                "                                                                        href=\"/profile/" + comment.authorLogin + "\">" + comment.authorLogin + "</a></p>\n" +
                "                                                                <small>" + date + "</small>\n" +
                "                                                            </div>\n" +
                "                                                            <div class=\"d-flex w-100 justify-content-between\">\n" +
                "                                                                <small class=\"mb-1\" data-contain-user-tags data-contain-hashtags>" + commentInput.value + "</small>\n" +
                "                                                                    <div class=\"text-right\">\n" +
                "                                                                        <button class=\"btn btn-sm btn-dark fa fa-trash-o\" data-comment-id=\"" + comment.id + "\"\n" +
                "                                                                                onclick=\"deleteComment(event)\">\n" +
                "                                                                        </button>\n" +
                "                                                                    </div>\n" +
                "                                                            </div>";
            commentsList.appendChild(commentElement);
            commentInput.value = "";
        },
        error: function () {
            alert("error");
        }
    })
}