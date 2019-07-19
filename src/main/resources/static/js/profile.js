function toggleActivePill(event) {
    var pills = document.querySelectorAll("#pills-tab .nav-link");
    var contents = document.querySelectorAll("#pills-tabContent .tab-pane")
    var activePill = document.getElementById(event.target.dataset.active+'-tab');
    var activeContent =  document.getElementById(event.target.dataset.active+'-content')
    pills.forEach(function (item) {
        if(activePill===item){
            item.className = "nav-link active";
        }
        else item.className = "nav-link";
    });
    contents.forEach(function (item) {
        if(activeContent===item){
            item.className = "tab-pane fade show active";
        }
        else item.className = "tab-pane fade";
    });
}
