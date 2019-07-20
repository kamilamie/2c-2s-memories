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
                    <a class="list-group-item list-group-item-action <#if section?? && section!="info"> <#else> active </#if>b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#info-content" role="tab">Edit profile info</a>
                    <a id="password" class="list-group-item list-group-item-action <#if section?? && section=="password"> active </#if>b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#password-content" role="tab">Change password</a>
                    <a id="privacy" class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3"
                       data-toggle="list" href="#privacy-content" role="tab">Privacy & Security</a>
                </div>
            </div>
            <div class="col-8 p-0">
                <div class="tab-content p-5">
                    <div class="tab-pane <#if section?? && section!="info"> <#else> active show </#if> fade" id="info-content" role="tabpanel">
                        <form method="post" enctype="multipart/form-data" action="/editProfile">


                            <div class="d-flex justify-content-center h-100 align-items-center">
                                <div class="col-4 d-flex justify-content-end">
                                    <img src="${user.photo_path}" id="avatar" class="img-fluid round-img-md shadow">
                                </div>
                                <div class="form-group col-8">
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-dark " type="button" onclick="getFile()"
                                                aria-describedby="fileHelp">Upload file
                                        </button>
                                        &nbsp;
                                        <button type="button" class="btn btn-sm btn-dark" data-toggle="modal"
                                                data-target="#deleteModal"><span class="fa fa-trash-o"></span></button>
                                    </div>

                                    <input type="file" class="form-control-file d-none" id="file" name="file"
                                           onchange="showHint()">
                                    <small id="hint" class="form-text text-muted">&nbsp;</small>
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
                    <div class="tab-pane fade <#if section?? && section=="password"> show active </#if>" id="password-content" role="tabpanel">
                        <div class="d-flex row justify-content-center">
                            <div class="form-group row d-flex justify-content-end col-10 align-items-center h-100 mb-4">
                                <img src="${user.photo_path}" id="avatar" class="img-fluid round-img-md shadow">
                                <div class="col-8">
                                    <h3>${user.login}</h3>
                                </div>
                            </div>
                            <form method="post" action="/editProfile/password" class="d-flex row justify-content-center">
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
                    <div class="tab-pane fade" id="privacy-content" role="tabpanel">privacy content</div>
                </div>
            </div>
        </div>

<#--<div class="row justify-content-center after-header m-b-20">
    <form method="post" class="col-sm-8 card card-body" enctype="multipart/form-data">
        <#if errors??>
            <#list errors as error>
        <h6 class="alert alert-danger">${error}</h6>
        <br>
            </#list>
        </#if>
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="${user.name}">
        </div>
        <div class="form-group">
            <label for="surname">Surname</label>
            <input type="text" class="form-control" id="surname" name="surname" value="${user.surname}">
        </div>
        <div class="form-group">
            <label for="login">Login</label>
            <input type="text" class="form-control" id="login" name="login" value="${user.login}">
        </div>
        <div class="form-group">
            <label for="new-password">New Password</label>
            <input type="password" class="form-control" id="new-password" name="newPassword">
        </div>
        <div class="form-group">
            <label for="old-password">Old Password</label>
            <input type="password" class="form-control" id="old-password" name="oldPassword">
        </div>
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" class="form-control" name="email" id="email" aria-describedby="emailHelp"
                   value="${user.email}">
        </div>
        <div class="form-group">
            <label for="city">City</label>
            <input type="text" class="form-control" id="city" name="city"
                   value="<#if user.city??>${user.city}</#if>">
        </div>
        <div class="form-group">
            <label for="dateOfBirth">Date of birth</label>
            <input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth"
                   value="<#if user.dateOfBirth??>${user.dateOfBirth}</#if>">
        </div>

        <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender">
                <option value=""
                    <#if !user.gender??>
                    selected
                    </#if>>not selected
                </option>
                <option value="male"
                    <#if user.gender?? && user.gender == "male">
                    selected
                    </#if>>male
                </option>
                <option value="female"
                    <#if user.gender?? && user.gender == "female">
                    selected
                    </#if>>female
                </option>
            </select>
        </div>

        <div class="form-group">
            <label for="file">Avatar</label>
            <input type="file" class="form-control-file" id="file" name="file" aria-describedby="fileHelp">
        </div>
        <div class="form-group text-center">


            <button type="submit" class="btn btn-outline-warning col-sm-3">Save changes</button>
        </div>
    </form>-->
<#else>
        <div class="text-center after-header" style="margin: auto">
            <h1>No such user</h1>
        </div>
</#if>

</div>
<script type="application/javascript" src="/js/edit-profile.js"></script>
<script>
    function getFile() {
        document.getElementById("file").click();
    }

    function showHint() {
        document.getElementById("hint").innerHTML = "File downloaded; check the rest and save";
    }
</script>

</body>

</html>