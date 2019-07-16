<#ftl encoding='UTF-8'>
<html>
<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/util.css">
    <link rel="stylesheet" type="text/css" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

</head>
<body class="bg-light poppins-regular">
<div class="d-flex justify-content-center">


    <div class="col-sm-4 p-5 m-5 shadow bg-white rounded">
        <div class="text-center mb-5">
            <h3>Sign Up</h3>
        </div>
        <#if error??>
                <p class="alert alert-primary small">Login or password are not valid!</p>

        </#if>
        <form method="post" action="/signUp">
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="enter first name">
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="enter last name">
            </div>
            <div class="form-group">
                <label for="login">Login</label>
                <input type="text" class="form-control" id="login" name="login" placeholder="enter login">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="enter password">
            </div>
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="remember-me">
                <label class="form-check-label" for="remember-me">Remember me</label>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-dark col-sm-6 mt-4">LOG IN</button>
            </div>
        </form>

        <hr>

        <p class="small text-secondary text-center">or sign in with</p>
        <div class="row justify-content-center">

            <span class="fa fa-google-plus-official fa-2x"></span>
            &nbsp;&nbsp;
            <span class="fa fa-vk fa-2x"></span>

        </div>
        <div class="text-center mt-5">
            <small>Already have an account? <a href="/login">Login</a></small>

        </div>
    </div>
</div>

<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
</body>
</html>