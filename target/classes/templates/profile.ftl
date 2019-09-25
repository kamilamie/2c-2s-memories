<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <title>Profile</title>
    <meta charset="utf-8">
</head>
<style>


    .post-modal:before {
        content: '';
        display: inline-block;
        height: 100%;
        vertical-align: middle;
    }


</style>
<body class="bg-light poppins-regular">
<#if user??>
<div class="container border-bottom mb-5">
    <div class="row p-4 mb-3 justify-content-center">
        <div class="col-sm-3 text-center">
            <img src="${user.photo_path}" alt="user avatar" class="img-fluid round-img shadow">
        </div>
        <div>
            <div class="d-flex justify-content-start align-items-center p-4">
                <div class="poppins-extra-light d-flex justify-content-center mr-5">
                    <span style="font-size: 35px">${user.login}</span>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn bg-white border" data-toggle="modal" data-target="#newPostModal">
                        <span class="fa fa-camera"></span> New post
                    </button>
                    &nbsp;
                    <form action="/editProfile">
                        <button class="btn btn-light border"><span class="fa fa-pencil"></span> Edit profile</button>
                    </form>
                    &nbsp;
                    <button class="btn btn-dark" onclick="location.href='/logout'"><span class="fa fa-sign-out"></span>
                        Logout
                    </button>
                </div>
            </div>
            <div class="d-flex justify-content-around pl-5 pr-5">
                <button class="btn" data-toggle="modal" id="followers-btn" onclick="toggleActivePill(event)" data-target="#subModal">
                    <strong id="followers">${user.followers?size}</strong> followers
                </button>
                <button class="btn" data-toggle="modal" id="followings-btn" onclick="toggleActivePill(event)" data-target="#subModal">
                    <strong id="followings">${user.followings?size}</strong> followings
                </button>
            </div>
            <div class="p-4">
                <strong>${user.firstName} <#if user.lastName??>${user.lastName}</#if></strong><br>
                ${user.email}<br>
                <#if user.city??>${user.city}</#if>
            </div>
        </div>

    </div>

    <!-- Modal for list of followers/followings-->
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
                                   aria-selected="true"><span id="followers-tab-size">${user.followers?size}</span> Followers</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="followings-tab" data-toggle="pill"
                                   href="#followings-content"
                                   role="tab" aria-controls="followers-content"
                                   aria-selected="false"><span id="followings-tab-size">${user.followings?size}</span> Followings</a>
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
                                                <#if ((user.followings)?seq_contains(follower))>
                                                    <button class="btn btn-outline-danger" data-login="${follower.login}" onclick="follow(event)">Unfollow</button>
                                                <#else>
                                                    <button class="btn btn-light" data-login="${follower.login}" onclick="follow(event)">Follow</button>
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

                                            <button class="btn btn-outline-danger" data-login="${following.login}" onclick="follow(event)">Unfollow</button>
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

    <!-- Modal for adding new post-->
    <div class="modal fade" id="newPostModal" tabindex="-1" role="dialog" aria-labelledby="newPostModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form method="post" enctype="multipart/form-data" id="newPostForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="newPostModalLabel">New post</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="file" name="file"
                                   aria-describedby="fileHelp">
                            <label class="custom-file-label" style="
                                                white-space: nowrap;
                                                overflow: hidden;
                                                text-overflow: ellipsis;" for="file">Choose file</label>
                            <#if errors?? && errors['file']??>
                            <small id="fileHelp" class="form-text text-danger">
                                ${errors['file']}
                            </small>
                            </#if>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" id="description" name="description" aria-describedby="descriptionHelp" placeholder="Enter description">
                            <#if errors?? && errors['description']??>
                                <small id="descriptionHelp" class="form-text text-danger">
                                    ${errors['description']}
                                </small>
                            </#if>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <#if user.posts?size == 0>
        <div class="text-center m-5">
            <h5>You don't have posts yet</h5>
        </div>
    <#else>
        <div class="card-columns">
            <#list user.posts as post>
                <div id="post${post.id}" class="card">
                    <img src="${post.photo_path}" class="card-img-top" alt="post photo" data-toggle="modal" data-target="#postModal${post.id}">
                </div>
            <#--Post modal-->

                <div class="modal fade post-modal text-center" id="postModal${post.id}"  tabindex="-1" role="dialog" aria-labelledby="postModalLabel" aria-hidden="true">
                    <div class="modal-dialog text-left d-inline-block mw-100" role="document">
                        <div class="modal-content">
                            <div class="modal-body p-0">
                                <div class="row m-3">
                                    <div>
                                        <img src="${post.photo_path}" style="max-height: 600px; max-width: 800px" >
                                    </div>
                                    <div style="width: 350px">
                                        <div class="card-block px-2">
                                            <div class="d-flex justify-content-between">
                                                <small>${post.date}</small>
                                                <div class="btn-group">
                                                    <#assign liked = false>
                                                    <#list post.likes as like>
                                                        <#if like.user.login == user.login>
                                                            <#assign liked = true>
                                                        </#if>
                                                    </#list>
                                                    <button onclick="like(event)" class="btn btn-sm btn-outline-danger"
                                                            data-post-id="${post.id}">
                                                        <span id="likes${post.id}">${post.likes?size}</span>
                                                        <span id="likesHeart${post.id}"
                                                              class="fa <#if liked == true> fa-heart <#elseif liked == false> fa-heart-o </#if>"></span>
                                                    </button>

                                                    <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#photoMapModal">
                                                        <span class="fa fa-map-marked-alt"></span> Show on map
                                                    </button>
                                                    <button class="btn btn-sm btn-dark fa fa-trash-o" data-post-id="${post.id}"
                                                            onclick="deletePost(event)">
                                                    </button>
                                                </div>
                                            </div>
                                            <br></br>
                                            <#if post.description?has_content>
                                                <h4 class="card-title text-center">${post.description}</h4>
                                                <hr>
                                            </#if>
                                            <h6 class="card-text">Comments:</h6>
                                            <div class="input-group mb-3">
                                                <input id="commentinput${post.id}" type="text" class="form-control form-control-sm col-sm-10"
                                                       placeholder="Leave your comment">
                                                <div class="input-group-append">
                                                    <button class="btn btn-sm btn-outline-secondary" type="button"
                                                            data-post-id="${post.id}"
                                                            onclick="addComment(event)">Send
                                                    </button>
                                                </div>
                                            </div>

                                                <div class="list-group list-group-flush" id="comments${post.id}">
                                                    <#if post.comments?size==0>
                                                        <p id="noComments${post.id}" class="text-center">No comments yet</p>
                                                    <#else>
                                                    <#list post.comments as comment>
                                                        <div id="comment${comment.id}" class="list-group-item flex-column align-items-start">
                                                            <div class="d-flex w-100 justify-content-between">
                                                                <p class="mb-1"><a
                                                                        href="/profile/${comment.author.login}">${comment.author.login}</a></p>
                                                                <small>${comment.date}</small>
                                                            </div>
                                                            <div class="d-flex w-100 justify-content-between">
                                                                <small class="mb-1" data-contain-user-tags data-contain-hashtags>${comment.text}</small>
                                                                <#if comment.author.login == user.login>
                                                                    <div class="text-right">
                                                                        <button class="btn btn-sm btn-dark fa fa-trash-o" data-comment-id="${comment.id}"
                                                                                onclick="deleteComment(event)">
                                                                        </button>
                                                                    </div>
                                                                </#if>
                                                            </div>
                                                        </div>
                                                    </#list>
                                                    </#if>
                                                </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </#if>
</div>
<#else>
<div class="text-center" style="margin: auto">
    <h1>No such user</h1>
</div>
</#if>

</body>
<script src="/js/new_photo_validate.js"></script>
<script src="/js/profile.js"></script>
<script type="text/javascript" src="/js/post.js"></script>
<script type="text/javascript">
    $(window).on('load',function(){
        <#if errors??&&(errors['description']??||errors['file']??)>
            $('#newPostModal').modal('show');
        </#if>

    });
</script>
</html>