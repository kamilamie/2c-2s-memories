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
function togglePrivateMode(event) {
    $.ajax({
        url: "ajax/togglePrivate",
        type: "post",
        success: function (msg) {
            var checkbox = document.getElementById('private');
            checkbox.attr("checked", !checkbox.attr("checked"));
        },
        error: function(msg){
            alert("error");
        }
    });
}
