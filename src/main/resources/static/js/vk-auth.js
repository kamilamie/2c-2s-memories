var user_id = null;
var token = null;

var token_key = "access_token";
var user_id_key = "user_id";

window.onload = function (ev) {
    getAllUrlParams(window.location.href);

    if (token != null && user_id != null) {
        getUsersData(token, user_id);
    }
};

function getAllUrlParams(url_string) {
    var url_replaced = url_string.replace('#', '?');
    var url = new URL(url_replaced);
    token = url.searchParams.get(token_key);
    user_id = url.searchParams.get(user_id_key);
}

function getUsersData(token, user_id) {
    var url = "https://api.vk.com/method/users.get?user_ids=" + user_id + "&access_token=" + token + "&v=5.101&fields=screen_name,photo_max_origin";
    $.ajax({
        url: url,
        type: 'GET',
        crossDomain: true,
        dataType: 'jsonp',
        success: function (data) {
            saveUser(data)
        },
        error: function () {
            alert('Failed!');
        }
    });

}
function saveUser(data) {
    var user = data.response[0];
    $.ajax({
        url: "/ajax/signUp_vk",
        type: "post",
        data: JSON.stringify(user),
        contentType: 'application/json; charset=utf-8',
        cache: false,
        dataType: "json",
        timeout: 300000,
        success: function (data) {
            window.location.replace('http://localhost:8080/profile');
        },
        error: function () {
            alert('Such user already exists');

        }
    })

}