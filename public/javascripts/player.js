
$(document).ready(function() {
    var socket = io.connect(window.location.origin);

    socket.on('connect', function () {
        socket.emit('register', {
            "boardId": boardId,
            "playerId": playerId
        });

        document.addEventListener("keydown", function(e){
            e = e || window.event;
            if (e.keyCode == '37') {
                // left arrow
                socket.emit('move',{
                    "boardId": boardId,
                    "playerId": playerId,
                    "direction": -30
                });
            }
            else if (e.keyCode == '39') {
                // right arrow
                socket.emit('move', {
                    "boardId": boardId,
                    "playerId": playerId,
                    "direction": 30
                });
            }
        }, false);
        
        if (window.DeviceOrientationEvent) {
            $('#doeSupported').html('');
            window.addEventListener('deviceorientation', function(evt){
                $('#beta').html(evt.beta.toFixed(0));
                socket.emit('move',{
                    "boardId": boardId,
                    "playerId": playerId,
                    "direction": evt.beta.toFixed(0) * 4
                });
            }, false);
        }
    });
});
