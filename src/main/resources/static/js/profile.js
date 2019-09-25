function toggleActivePill(event) {
    var link_id = event.currentTarget.id;
    if (link_id === "followers-btn")
        $('#followers-tab').tab('show');
    else if (link_id === "followings-btn") $('#followings-tab').tab('show');
}

function follow(event) {
    var followBtn = event.currentTarget;
    $.ajax({
        url: "/ajax/follow",
        type: "post",
        data: {
            "login": followBtn.dataset.login
        },
        success: function (msg) {
            if (window.location.pathname === "/profile") {
                var followings = document.getElementById("followings");
                if (msg === true) {
                    followings.innerHTML++;
                    document.getElementById("followings-tab-size").innerHTML++;
                    followBtn.className = "btn btn-outline-danger";
                    followBtn.innerHTML = "Unfollow";
                } else if (msg === false) {
                    followings.innerHTML--;
                    document.getElementById("followings-tab-size").innerHTML--;
                    followBtn.className = "btn btn-light";
                    followBtn.innerHTML = "Follow";
                }
            }
            else {
                var followers = document.getElementById("followers");

                if (followBtn === document.getElementById("follow-btn")) {
                    if (msg === true) {
                        followers.innerHTML++;
                        followBtn.innerHTML = "<span class=\"fa fa-user-times\"></span> Unfollow";
                    } else if (msg === false) {
                        followers.innerHTML--;
                        followBtn.innerHTML = "<span class=\"fa fa-user-plus\"></span> Follow";
                    }
                } else {
                    if (msg === true) {
                        followBtn.className = "btn btn-outline-danger";
                        followBtn.innerHTML = "Unfollow";
                    } else if (msg === false) {
                        followBtn.className = "btn btn-light";
                        followBtn.innerHTML = "Follow";
                    }
                }
            }

        },
        error: function (msg) {
            alert("error");
        }
    });
}

$('#file').on('change', function () {
    var fileName = $(this).val();
    $(this).next('.custom-file-label').html(fileName);
})
