/**
 * Created by Tomasz on 2015-04-06.
 */
$(document).ready(function() {
    var socket = io.connect(window.location.origin);

    socket.on('connect', function () {
        var player1Link = window.location.href + "/" + socket.id + "/player/1";
        var player2Link = window.location.href + "/" + socket.id + "/player/2";
        //var player1Link = "http://192.168.0.2:3000/board" + "/" + socket.id + "/player/1";
        //var player2Link = "http://192.168.0.2:3000/board" + "/" + socket.id + "/player/2";
        new QRCode(document.getElementById("qrcodeP1"), player1Link);
        new QRCode(document.getElementById("qrcodeP2"), player2Link);
        $("#qrcodeP1 img").attr("onclick", "window.open('" + player1Link + "')");
        $("#qrcodeP2 img").attr("onclick", "window.open('" + player2Link + "')");

        console.log('connect ', socket.id);
        socket.on('register', function (data) {
            if(data == 1){
                $("#qrcodeP1").attr("class", "connected").html("<h2>Connected</h2>");
            }else if(data == 2) {
                $("#qrcodeP2").attr("class", "connected").html("<h2>Connected</h2>");
            }
        });
        socket.on('move', function (data) {
            var canvas = Processing.getInstanceById('__processing0');
            if(data.playerId == 1){
                canvas.movePaddle1(parseInt(data.direction));
            }else if(data.playerId == 2){
                canvas.movePaddle2(parseInt(data.direction));
            }
        });
        var bound = false;
        function bindGameEvents(){
            var canvas = Processing.getInstanceById('__processing0');
            try {
                canvas.bindGameEvents(this);
                bound = true;
            }catch(err){
                console.log(err.message);
            }
            if(!bound) setTimeout(bindGameEvents, 250);
        }
        bindGameEvents();
    });
});
function goal(playerId){
    if(playerId == 1){
        $("#scoreP1").html(parseInt($("#scoreP1").text()) + 1)
    }else if(playerId == 2){
        $("#scoreP2").html(parseInt($("#scoreP2").text()) + 1)
    }
}