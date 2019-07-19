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
                    <a class="list-group-item list-group-item-action active b-color-trans pl-5 pr-5 pt-3 pb-3" data-toggle="list" href="#info-content" role="tab">Edit profile info</a>
                    <a class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3" data-toggle="list" href="#password-content" role="tab">Change password</a>
                    <a class="list-group-item list-group-item-action b-color-trans pl-5 pr-5 pt-3 pb-3" data-toggle="list" href="#privacy-content" role="tab">Privacy & Security</a>
                </div>
            </div>
            <div class="col-8 p-0">
                <div class="tab-content">
                    <div class="tab-pane active show fade" id="info-content" role="tabpanel">info content</div>
                    <div class="tab-pane fade" id="password-content" role="tabpanel">password content</div>
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
<script type="application/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<script type="application/javascript" src="/js/profile.js"></script>
</body>

</html>