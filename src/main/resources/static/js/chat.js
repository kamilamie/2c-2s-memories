document.addEventListener("DOMContentLoaded", connect);
var stompClient = null;

function connect() {
    var socket = new SockJS('/websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        stompClient.subscribe('/user/queue/chat',
            function (message) {
                addMessage(JSON.parse(message.body));
            }
        );
        stompClient.subscribe('/user/queue/deleteMessage',
            function (message) {
                removeMessage(JSON.parse(message.body));
            }
        );
    });
}

function addMessage(message) {
    var messDiv = document.createElement('div');
    messDiv.id = message.id;

    var style = 'd-flex justify-content-start';

    if(message.receiverLogin === $("#partner").val())
        style = 'd-flex justify-content-end';
    messDiv.className = style;

    var date = new Date(message.date);
    var newDate = ('0' + date.getDate()).slice(-2) + "."
        + ('0' + (1 + +date.getMonth())).slice(-2) + "."
        + date.getUTCFullYear() + " "
        + date.getHours() + ":" +
        +date.getMinutes() + ":" +
        +date.getSeconds();

    messDiv.innerHTML = "<div class=\"d-flex justify-content-center align-items-center\">\n" +
        "                    <h5>"+message.text+"</h5>\n" +
        "                    &nbsp;\n" +
        "                    <small class=\"text-muted\">"+newDate+"</small>\n" +
        "                </div>";
    var list = document.getElementById("messages");
    document.getElementById("messages").appendChild(messDiv);
}

function sendMessage() {
    stompClient.send("/app/message", {}, JSON.stringify({
        'receiverLogin': $("#partner").val(),
        'text': $("#message").val()
    }));
    document.getElementById("message").value = "";
}

$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $("#send").click(function () {
        sendMessage();
    });
});

function deleteMessage(event) {
    var messageId = event.t.dataset.id;
    stompClient.send("/app/deleteMessage", {}, JSON.stringify({
        'messageId': messageId,
        'partnerLogin': $("#partner").val()
    }));
}

function removeMessage(id) {
    document.getElementById(id).remove();
}