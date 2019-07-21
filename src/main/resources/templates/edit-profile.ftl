<#ftl encoding='UTF-8'>
<#include "header.ftl">
<html>
<head>
    <title>Edit profile &middot; ${user.login}</title>
    <meta charset="utf-8">
</head>
<body class="bg-light poppins-regular">
<#if user??>
<div class="d-flex container p-5 justify-content-center">

        <div class="row bg-white rounded border col-10 p-0 ">
            <div class="col-4 p-0 border-right">
                <div class="list-group" id="settingsList" role="tablist">
                    <a id="info" class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#info-content" role="tab">Edit profile info</a>
                    <a id="password"
                       class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#password-content" role="tab">Change password</a>
                    <a id="privacy" class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#privacy-content" role="tab">Privacy & Security</a>
                </div>
            </div>
            <div class="col-8 p-0">
                <div class="tab-content p-5">
                    <div class="tab-pane fade" id="info-content" role="tabpanel">
                        <form method="post" enctype="multipart/form-data" action="/editProfile">
                            <div class="d-flex justify-content-center h-100 align-items-center">
                                <div class=" d-flex justify-content-end">
                                    <img src="${user.photo_path}" id="avatar" class="img-fluid round-img-md shadow">
                                </div>
                                <div class="form-group col-7">
                                    <div class="btn-group">
                                        <div class="input-group-sm">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input file-" id="file" name="file"
                                                       aria-describedby="fileHelp">
                                                <label class="custom-file-label" style="
                                                    white-space: nowrap;
                                                    overflow: hidden;
                                                    text-overflow: ellipsis;" for="file">Choose file</label>
                                            </div>
                                        </div>
                                        &nbsp;
                                        <button type="button" class="btn btn-sm btn-dark" data-toggle="modal"
                                                data-target="#deleteModal"><span class="fa fa-trash-o"></span></button>
                                    </div>
                                        <#if errors?? && errors['file']??>
                                            <small id="fileHelp" class="form-text text-danger">
                                                ${errors['file']}
                                            </small>
                                        </#if>
                                </div>
                            </div>
                            <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Confirmation</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete your avatar photo?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                Cancel
                                            </button>
                                            <button type="button" class="btn btn-danger" data-dismiss="modal"
                                                    onclick="deletePhoto(event)">Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4 mr-5">
                                <div class="form-group row justify-content-end d-flex">
                                    <label for="firstName" class="col-form-label justify-content-end d-flex">First
                                        name</label>
                                    <div class="col-8">
                                        <input type="text" class="form-control" id="firstName" name="firstName"
                                               value="${user.firstName}" aria-describedby="firstNameHelp">
                                        <#if errors?? && errors['firstName']??>
                                            <small id="firstNameHelp" class="form-text text-danger">
                                                ${errors['firstName']}
                                            </small>
                                        </#if>
                                    </div>
                                </div>
                                <div class="form-group row justify-content-end d-flex">
                                    <label for="lastName" class="col-form-label justify-content-end d-flex">Last
                                        name</label>
                                    <div class="col-8">
                                        <input type="text" class="form-control" id="lastName" name="lastName"
                                               aria-describedby="lastNameHelp"
                                               value="<#if user.lastName??>${user.lastName}</#if>">
                                        <#if errors?? && errors['lastName']??>
                                            <small id="lastNameHelp" class="form-text text-danger">
                                                ${errors['lastName']}
                                            </small>
                                        </#if>
                                    </div>
                                </div>
                                <div class="form-group row justify-content-end d-flex">
                                    <label for="login" class="col-form-label justify-content-end d-flex">Login</label>
                                    <div class="col-8">
                                        <input type="text" class="form-control" id="login" name="login"
                                               aria-describedby="loginHelp"
                                               value="${user.login}">
                                        <#if errors?? && errors['login']??>
                                            <small id="loginHelp" class="form-text text-danger">
                                                ${errors['login']}
                                            </small>
                                        </#if>
                                    </div>
                                </div>

                                <div class="form-group row justify-content-end d-flex">
                                    <label for="email" class="col-form-label justify-content-end d-flex">Email</label>
                                    <div class="col-8">
                                        <input type="text" class="form-control" id="email" name="email"
                                               aria-describedby="emailHelp"
                                               value="${user.email}">
                                        <#if errors?? && errors['email']??>
                                            <small id="emailHelp" class="form-text text-danger">
                                                ${errors['email']}
                                            </small>
                                        </#if>
                                    </div>

                                </div>
                                <div class="form-group row justify-content-end d-flex">
                                    <label for="city" class="col-form-label justify-content-end d-flex">City</label>
                                    <div class="col-8">
                                        <input type="text" class="form-control" id="city" name="city"
                                               value="<#if user.city??>${user.city}</#if>">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group text-center mr-4 pr-2">
                                <button type="submit" class="btn btn-outline-warning">Save changes</button>
                            </div>

                        </form>
                    </div>
                    <div class="tab-pane fade"
                         id="password-content" role="tabpanel">
                        <div class="d-flex row justify-content-center">
                            <div class="form-group row d-flex justify-content-end col-10 align-items-center h-100 mb-4">
                                <img src="${user.photo_path}" id="avatar" class="img-fluid round-img-md shadow">
                                <div class="col-8">
                                    <h3>${user.login}</h3>
                                </div>
                            </div>
                            <form method="post" action="/editProfile/password"
                                  class="d-flex row justify-content-center">
                                <div class="form-group row justify-content-end col-9">
                                    <label for="old-password" class="col-form-label">Old Password</label>
                                    <div class="col-8">
                                        <input type="password" class="form-control" id="old-password" name="oldPassword"
                                               aria-describedby="oldPasswordHelp">
                                        <#if errors?? && errors['oldPassword']??>
                                            <small id="oldPasswordHelp" class="form-text text-danger">
                                                ${errors['oldPassword']}
                                            </small>
                                        </#if>
                                    </div>
                                </div>
                                <div class="form-group row justify-content-end col-9">
                                    <label for="new-password" class="col-form-label">New Password</label>
                                    <div class="col-8">
                                        <input type="password" class="form-control" id="new-password" name="newPassword"
                                               aria-describedby="newPasswordHelp">
                                        <#if errors?? && errors['newPassword']??>
                                            <small id="newPasswordHelp" class="form-text text-danger">
                                                ${errors['newPassword']}
                                            </small>
                                        </#if>
                                    </div>
                                </div>

                                <div class="form-group row justify-content-end col-9">
                                    <div class="col-8">
                                        <button type="submit" class="btn btn-outline-warning">Change password</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="privacy-content" role="tabpanel">
                        <h5 class="mb-4">Account privacy</h5>
                        <form>
                            <div class="form-check">
                                <input type="checkbox"  <#if user.isPrivate==true> checked </#if>
                                       class="form-check-input"
                                       aria-describedby="privateHelp" onclick="togglePrivateMode(event)" id="private">
                                <label class="form-check-label" for="private">Private account</label>
                            </div>
                            <small id="privateHelp" class="form-text text-muted">If you have a private account, only
                                people subscribed to you
                                will be able to see your photos.
                            </small>

                        </form>
                    </div>
                </div>
            </div>
        </div>
<#else>
        <div class="text-center after-header" style="margin: auto">
            <h1>No such user</h1>
        </div>
</#if>

</div>
<script type="application/javascript" src="/js/edit-profile.js"></script>
<script>
    $(function () {
        var path = window.location.pathname;
        if (path.includes("password"))
            $('#password').tab('show');
        else $('#info').tab('show');
    })
    $('#file').on('change', function () {
        var fileName = $(this).val();
        $(this).next('.custom-file-label').html(fileName);
    })
</script>
</body>

</html>