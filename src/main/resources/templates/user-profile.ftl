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
        <div class="col-sm-3 text-center">
            <img src="${user.photo_path}" alt="user avatar" class="img-fluid round-img shadow">
        </div>
        <div>
            <div class="d-flex justify-content-start align-items-center p-4">
                <div class="poppins-extra-light d-flex justify-content-center mr-4">
                    <span style="font-size: 35px">${user.login}</span>
                </div>
                <div class="btn-group">
                    <#if currentUserId??>
                        <#assign followedByCurrentUser = false>
                        <#list user.followers as follower>
                            <#if follower.id == currentUserId>
                                <#assign followedByCurrentUser = true>
                            </#if>
                        </#list>
                    <button id="follow-btn" class="btn bg-white border" style="width: 150px" data-login="${user.login}" onclick="follow(event)">
                        <#if !followedByCurrentUser>
                            <span class="fa fa-user-plus"></span> Follow
                        <#else>
                        <span class="fa fa-user-times"></span> Unfollow
                        </#if>
                    </button>
                    &nbsp;
                    </#if>
                    <button class="btn btn-dark"><span class="fa fa-commenting-o"></span> Message</button>
                </div>
            </div>
            <div class="d-flex justify-content-around pl-4 pr-4">
                <button class="btn" data-toggle="modal" data-active="followers" onclick="toggleActivePill(event)" data-target="#subModal">
                    <strong id="followers">${user.followers?size}</strong> followers
                </button>
                <button class="btn" data-toggle="modal" data-active="followings" onclick="toggleActivePill(event)" data-target="#subModal">
                    <strong is="followings">${user.followings?size}</strong> followings
                </button>
            </div>
            <div class="pl-4 pt-5">
                <strong>${user.firstName} <#if user.lastName??>${user.lastName}</#if></strong>
                <p>${user.email}</p>
                <#if user.city??><p>${user.city}</p></#if>
            </div>
        </div>

    </div>
    <div class="bd-example">
        <div class="modal fade" id="subModal" tabindex="-1" role="dialog"
             aria-labelledby="subModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link" id="followers-tab" data-toggle="pill"
                                   href="#followers-content"
                                   role="tab" aria-controls="followers-content"
                                   aria-selected="true">${user.followers?size} Followers</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="followings-tab" data-toggle="pill"
                                   href="#followings-content"
                                   role="tab" aria-controls="followers-content"
                                   aria-selected="false">${user.followings?size} Followings</a>
                            </li>
                        </ul>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="max-height: 550px; overflow-y: auto;">
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade" id="followers-content" role="tabpanel"
                                 aria-labelledby="followers-tab">
                                        <#list user.followers as follower>
                                            <div class="align-items-center d-flex justify-content-between pl-5 pr-5">
                                                <div class="d-flex justify-content-start align-items-center">
                                                    <img src="${follower.photo_path}" alt="user avatar"
                                                         class="round-img-sm shadow mr-3">
                                                    <a href="/profile/${follower.login}">${follower.login}</a>
                                                </div>
                                                <#if currentUserId!=follower.id>
                                                    <#if currUserFollowings?seq_contains(follower)>
                                                    <button class="btn btn-outline-danger" data-login="${follower.login}" onclick="follow(event)">Unfollow</button>
                                                    <#else>
                                                    <button class="btn btn-light" data-login="${follower.login}" onclick="follow(event)">Follow</button>
                                                    </#if>
                                                </#if>

                                            </div>
                                            <hr>
                                        </#list>
                            </div>
                            <div class="tab-pane fade" id="followings-content" role="tabpanel"
                                 aria-labelledby="followings-tab">
                                        <#list user.followings as following>
                                            <div class="align-items-center d-flex justify-content-between pl-5 pr-5">
                                                <div class="d-flex justify-content-start align-items-center">
                                                    <img src="${following.photo_path}" alt="user avatar"
                                                         class="round-img-sm shadow mr-3">
                                                    <a href="/profile/${following.login}">${following.login}</a>
                                                </div>
                                                <#if currentUserId!=following.id>
                                                    <#if currUserFollowings?seq_contains(following)>
                                                        <button class="btn btn-outline-danger" data-login="${following.login}" onclick="follow(event)">Unfollow</button>
                                                    <#else>
                                                        <button class="btn btn-light" data-login="${following.login}" onclick="follow(event)">Follow</button>
                                                    </#if>
                                                </#if>
                                            </div>
                                            <hr>
                                        </#list>
                            </div>
                        </div>
                    </div>
                </div>
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
<script src="/js/profile.js"></script>
</html>