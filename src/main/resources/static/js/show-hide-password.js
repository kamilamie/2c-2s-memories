var showPass = 0;
$('.btn-show-pass').on('click', function(){
    if(showPass == 0) {
        $('#password').attr('type','text');
        $(this).find('i').removeClass('fa-eye');
        $(this).find('i').addClass('fa-eye-slash');
        showPass = 1;
    }
    else {
        $('#password').attr('type','password');
        $(this).find('i').addClass('fa-eye');
        $(this).find('i').removeClass('fa-eye-slash');
        showPass = 0;
    }

});