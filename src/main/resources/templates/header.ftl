<#ftl encoding='UTF-8'>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="/css/util.css">
    <link type="text/css" rel="stylesheet" href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<body>
<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-white p-3">
    <div class="container">


        <a class="navbar-brand" style="font-size: 25px" href="#">Memories</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggler"
                aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarToggler">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                <li id="feed" class="nav-item">
                    <a class="nav-link" style="font-size: 20px" href="/feed">Feed</a>
                </li>
                <li id="chats" class="nav-item">
                    <a class="nav-link" style="font-size: 20px" href="/chats">Chats</a>
                </li>
                <li id="profile" class="nav-item">
                    <a class="nav-link" style="font-size: 20px" href="/profile">Profile</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search">
                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>

<script type="text/javascript" src="/js/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/lib/popper.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.js"></script>
</body>
</html>