<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <meta charset="UTF-8">
    <title>Chats</title>
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
<body class="bg-light poppins-regular">
<div class="container col-sm-6">
    <br></br>
    <#if chats?has_content>
        <div class="text-center">
            <h4>
                Choose chat:
            </h4>
        </div>
        <br>
    <input id="currentUserLogin" value="${currentUser.login}" hidden>
        <div id="chats" class="border rounded p-4 bg-white">
            <#list chats as chat>
                <#if chat.sender.login == currentUser.login>
                    <#assign partner = chat.receiver>
                <#else>
                    <#assign partner = chat.sender>
                </#if>
                <div id="${partner.login}">
                    <div class="d-flex justify-content-start m-2">
                        <img src="${partner.photo_path}" alt="user avatar" class="img-fluid round-img-lg shadow">
                        <span style="font-size: 25px" class="m-3"><a href="/profile/${partner.login}">${partner.login}</a></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 id="${partner.login}Message" class="m-3">${chat.text}</h5>
                        <div class="btn-group">
                            <button class="btn btn-sm btn-outline-dark" data-partner-login="${partner.login}" onclick="openChat(event)">
                                go to chat
                            </button>
                            &nbsp;
                            <button class="btn-dark">
                                <span class="fa fa-trash-o"></span>
                            </button>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end">
                        <small id="${partner.login}Date">${chat.date}</small>
                    </div>
                    <hr>
                </div>

            </#list>
        </div>
    <#else>
    <div class="text-center">
        <h2>You don't have chats yet</h2>
    </div>
    </#if>
    <br>
</div>
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script type="application/javascript" src="/js/chats.js"></script>
</body>
</html>