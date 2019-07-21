function toggleActivePill(event) {
    var pills = document.querySelectorAll("#pills-tab .nav-link");
    var contents = document.querySelectorAll("#pills-tabContent .tab-pane");
    var activePill = document.getElementById(event.currentTarget.dataset.active + '-tab');
    var activeContent = document.getElementById(event.currentTarget.dataset.active + '-content');
    pills.forEach(function (item) {
        if (activePill === item) {
            item.className = "nav-link active";
        }
        else item.className = "nav-link";
    });
    contents.forEach(function (item) {
        if (activeContent === item) {
            item.className = "tab-pane fade show active";
        }
        else item.className = "tab-pane fade";
    });
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

                if(followBtn ===document.getElementById("follow-btn")){
                    if(msg===true){
                        followers.innerHTML++;
                        followBtn.innerHTML = "<span class=\"fa fa-user-times\"></span> Unfollow";
                    } else if (msg === false){
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
