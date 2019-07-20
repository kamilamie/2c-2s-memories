function deletePhoto(event) {
    var login = event.target.dataset.login;
    $.ajax({
        url: "ajax/deletePhoto",
        type: "post",
        success: function (msg) {
            document.getElementById("avatar").src = msg;
        },
        error: function (msg) {
            alert("error");
        }
    });
}
