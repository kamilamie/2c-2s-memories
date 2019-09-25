<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat with ${partner}</title>
</head>
<style>
    .round-img-lg{
        width: 60px;
        height: 60px;
        border-radius: 50%; /* Радиус скругления */
        border: 3px solid white; /* Параметры рамки */
        object-fit: cover;
        vertical-align: middle;
    }
</style>
<body class="poppins-regular bg-light">
    <input id="partner" value="${partner.login}" hidden>
    <div class="d-flex justify-content-center m-3">
        <img src="${partner.photo_path}" alt="user avatar" class="img-fluid round-img-lg shadow">
        <span style="font-size: 25px" class="m-3"><a href="/profile/${partner.login}">${partner.login}</a></span>
    </div>
    <div id="messages" class="col-sm-6 border-left border-right m-auto p-4">
        <form>
            <div class="form-row">
                <input type="text" id="message" class="form-control col-sm-9" placeholder="Your message here...">
                <div class="col-sm-3">
                    <button id="send" class="btn btn-outline-dark col-sm-12" type="submit">Send</button>
                </div>
            </div>
        </form>
        <br></br>
        <#list messages as message >
            <div id="${message.id}" class="d-flex <#if message.sender.login==partner.login>justify-content-start<#else>justify-content-end</#if>">
                <div class="d-flex justify-content-center align-items-center">
                    <h5>${message.text}</h5>
                    &nbsp;
                    <small class="text-muted">${message.date}</small>
                </div>
            </div>
        </#list>


    </div>

</body>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/js/chat.js"></script>
</html>