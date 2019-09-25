<#ftl encoding='UTF-8'>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/util.css">
    <link type="text/css" rel="stylesheet" href="/css/login-validate.css">
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

</head>
<body class="bg-light poppins-regular">
<div class="container">


<div class="row justify-content-between col-sm-11 shadow bg-white rounded m-5">
    <div class="col-sm-6">
        <img src="/images/sign-up.png" class="pic-v-center">
    </div>

    <div class="col-sm-6 border-left">
        <div class="d-flex justify-content-center">

            <div class="col-sm-11 p-5 ">
                <div class="text-center mb-4">
                    <h3>Sign Up</h3>
                </div>

                <form method="post" action="/signUp" class="validate-form" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name">
                    </div>
                    <div class="form-group validate-input" data-validate="Invalid login">
                        <input type="text" class="form-control input-item" id="login" name="login" placeholder="Login">
                    </div>
                    <div class="form-group validate-input" data-validate="Valid email is a@b.c">
                        <input type="text" class="form-control input-item" id="email" name="email" placeholder="Email" >
                    </div>

                    <div class="form-group validate-input" data-validate="Invalid password">
                        <input type="password" class="form-control input-item" id="password" name="password" placeholder="Password">
                    </div>
                    <div class="form-group">
                        <input type="file" class="" id="file" name="file" placeholder="Photo">
                    </div>
                    <div class="text-center" style="position: relative">
                        <button type="submit" class="btn btn-dark col-sm-6 mt-4">SIGN UP</button>
                        <#if errors??>
                            <span class="fa fa-exclamation ml-2" data-toggle="tooltip" data-placement="right" title="
                            <#list errors as error>
                                ${error}
                            </#list>"
                                  style="color: red;  position: absolute; top: 60%;">
                            </span>
                        </#if>
                    </div>
                </form>
                <hr>

                <p class="small text-secondary text-center">or sign in with</p>
                <div class="row justify-content-center">

                    <span class="fa fa-google-plus-official fa-2x"></span>
                    &nbsp;&nbsp;
                    <a href="https://oauth.vk.com/authorize?client_id=7146050&display=popup&redirect_uri=http://localhost:8080/signUp&response_type=token&revoke=1&v=5.101">
                        <span class="fa fa-vk fa-2x"></span></a>

                </div>
                <div class="text-center mt-5">
                    <small>Already have an account? <a href="/login">log in</a></small>
                </div>
            </div>
        </div>
    </div>

</div>
</div>

<script type="text/javascript" src="/js/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/lib/popper.min.js"></script>
<script type="text/javascript" src="/js/registration-validate.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.js"></script>
<script type="text/javascript" src="/js/vk-auth.js"></script>
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
</body>
</html>