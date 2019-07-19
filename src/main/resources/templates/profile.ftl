<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <title>Profile</title>
    <meta charset="utf-8">
</head>
<body class="bg-light poppins-regular">
<br>
<#if user??>
<div class="container border-bottom">
    <div class="row p-4 justify-content-center">
        <div class="col-sm-4 text-center">
            <img <#if user.photo_path??> src="${user.photo_path}"<#else>
                                                src="/images/default_user_photo.png" </#if> alt="user avatar"
                                         class="img-fluid round-img shadow">
        </div>
        <div class="col-sm-7">
            <div class="d-flex justify-content-center align-items-center p-4">
                <div class=" poppins-extra-light mr-4">
                    <span style="font-size: 35px">${user.login}</span>
                </div>
                <div class="btn-group ml-3">
                    <button class="btn bg-white border">
                        <span class="fa fa-camera"></span> Upload photo
                    </button>
                    &nbsp;
                    <button class="btn btn-outline-dark"><span class="fa fa-pencil"></span> Edit profile</button>
                    &nbsp;
                    <button class="btn btn-dark" onclick="location.href='/logout'"><span class="fa fa-sign-out"></span>
                        Logout
                    </button>
                </div>
            </div>
            <div class="d-flex justify-content-around pl-5 pr-5">
                <div>
                    <strong>${user.followers?size}</strong> followers
                </div>
                <div>
                    <strong>${user.followings?size}</strong> followings
                </div>
            </div>
            <div class="pl-5 pt-5">
                <strong>${user.firstName} <#if user.lastName??>${user.lastName}</#if></strong>
                <p>${user.email}</p>
                <#if user.city??><p>${user.city}</p></#if>
            </div>
        </div>
    </div>



</div>


<#else>
<div class="text-center after-header" style="margin: auto">
    <h1>No such user</h1>
</div>
</#if>

</body>
</html>