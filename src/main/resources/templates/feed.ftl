<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <title>Feed</title>
    <meta charset="utf-8">
</head>
<body class="poppins-regular bg-light">
    <div class="container col-sm-5">
    <#list feedPosts as post>
        <br>
        <div id="post${post.id}" class="card">
            <div class="card-header bg-white d-flex justify-content-start">
                <img src="${post.author.photo_path}" alt="user avatar" class="img-fluid round-img-xs shadow">

                    <a style="font-size: 23px" class="m-2" href="/profile/${post.author.login}">${post.author.login}</a>

            </div>
            <img class="card-img-top" src="${post.photo_path}" alt="Card image cap">
            <div class="card-body">
                <div class="btn-group">
                <#if currentUserId??>
                    <#assign liked = false>
                    <#list post.likes as like>
                        <#if like.user.id == currentUserId>
                            <#assign liked = true>
                        </#if>
                    </#list>
                    <button onclick="like(event)" class="btn btn-sm btn-outline-danger"
                            data-post-id="${post.id}">
                        <span id="likes${post.id}">${post.likes?size}</span>
                        <span id="likesHeart${post.id}"
                              class="fa <#if liked == true> fa-heart <#elseif liked == false> fa-heart-o </#if>"></span>
                    </button>
                    <#else>
                        <form action="/login">
                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                <span id="likes${post.id}">${post.likes?size}</span>
                                <span id="likesHeart${post.id}" class="fa fa-heart-o"></span>
                            </button>
                        </form>
                    </#if>

                    <button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal"
                            data-target="#showMapModal" onclick="showMapInModal(event)" data-id="${post.id}" data-x="${post.coordinateX}"
                            data-y="${post.coordinateY}">
                        Show on map
                    </button>
                    <div class="bd-example">
                        <div class="modal fade" id="showMapModal" tabindex="-1" role="dialog"
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="exampleModalLabel">Photo map</h4>
                                        <button type="button" class="close" data-dismiss="modal"
                                                aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div style="margin: auto; width: 400px; height: 400px" id="map${post.id}"
                                             class="map">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br></br>
                <#if post.description?has_content>
                    <p class="card-text">${post.description}</p>
                    <hr>
                </#if>
                <h6 class="card-text">Comments:</h6>
                <#if currentUserId??>
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
                </#if>

                <div class="list-group list-group-flush" id="comments${post.id}">
                    <#if post.comments?size==0>
                        <p class="text-center">No comments yet</p>
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
                                <#if currentUserId?? && comment.author.id == currentUserId>
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
                <p class="card-text">
                    <small class="text-muted">${post.date}</small>
                </p>
            </div>
        </div>
    </#list>
</div>
<script type="text/javascript" src="/js/profile.js"></script>
<script type="text/javascript" src="/js/post.js"></script>
<script type="application/javascript" src="/js/maps.js"></script>
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU&amp;apikey=ba0d1ebb-c4a5-4a00-af89-2882eb642996"
        type="text/javascript"></script>
<script type="application/javascript" src="/js/photo-map.js"></script>
</body>
</html>
