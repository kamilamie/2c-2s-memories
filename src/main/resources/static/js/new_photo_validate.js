
(function ($) {
    "use strict";

    $('#newPostForm').on('submit',function(){
        var check = true;

        var fileInput = $('#newPostForm .custom-file-input');
        if (fileInput.get(0).files.length === 0) {
            var small = document.createElement('small');
            small.id = 'fileHelp';
            small.className = 'form-text text-danger';
            small.innerText = 'photo is not uploaded';
            fileInput.parent().append(small);
            check = false;
        }
        return check;
    });

})(jQuery);