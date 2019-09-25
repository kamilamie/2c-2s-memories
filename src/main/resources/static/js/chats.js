document.addEventListener("DOMContentLoaded", connect);
var stompClient = null;

function openChat(event) {
    var partnerLogin = event.target.dataset.partnerLogin;
    window.location.assign("/chat?login=" + partnerLogin);
}

function connect() {
    var socket = new SockJS('/websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        stompClient.subscribe('/user/queue/update',
            function (message) {
                update(JSON.parse(message.body));
            }
        );
    });
}

function update(message) {
    var currentUserLogin = document.getElementById("currentUserLogin").value;
    var partner = (message.senderLogin !== currentUserLogin) ? message.senderLogin : message.receiverLogin;
    var chat = document.getElementById(partner);
    var chats = document.getElementById("chats");

    var date = new Date(message.date);
    var new_date = ('0' + date.getDate()).slice(-2) + "."
        + ('0' + (1 + +date.getMonth())).slice(-2) + "."
        + date.getUTCFullYear() + " "
        + date.getHours() + ":" +
        +date.getMinutes() + ":" +
        +date.getSeconds();

    if (chat === null || chat === undefined) {
        var newChat = document.createElement('div');
        newChat.id = partner;
        newChat.innerHTML = "<div class=\"d-flex justify-content-start m-2\">\n" +
            "                        <img src=\""+message.photo_path+"\" alt=\"user avatar\" class=\"img-fluid round-img-lg shadow\">\n" +
            "                        <span style=\"font-size: 25px\" class=\"m-3\"><a href=\"/profile/"+partner+"\">"+partner+"</a></span>\n" +
            "                    </div>\n" +
            "                    <div class=\"d-flex justify-content-between align-items-center\">\n" +
            "                        <h5 class=\"m-3\">"+message.text+"</h5>\n" +
            "                        <div class=\"btn-group\">\n" +
            "                            <button class=\"btn btn-sm btn-outline-dark\" data-partner-login=\"${partner.login}\" onclick=\"openChat(event)\">\n" +
            "                                go to chat\n" +
            "                            </button>\n" +
            "                            &nbsp;\n" +
            "                            <button class=\"btn-dark\">\n" +
            "                                <span class=\"fa fa-trash-o\"></span>\n" +
            "                            </button>\n" +
            "                        </div>\n" +
            "                    </div>\n" +
            "                    <div class=\"d-flex justify-content-end\">\n" +
            "                        <small>"+new_date+"</small>\n" +
            "                    </div>\n" +
            "                    <hr>";

        chats.insertBefore(newChat, chats.firstChild);
    } else {
        var text = document.getElementById(partner+"Message");
        text.innerHTML = message.text;
        var changedDate = document.getElementById(partner+"Date");
        changedDate.innerHTML = new_date;
        chats.removeChild(chat);
        alert(chat.innerHTML);
        chats.insertBefore(chat, chats.firstChild);

    }
}

