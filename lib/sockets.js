var socket = require('socket.io');

module.exports.listen = function(app){
    var io = socket.listen(app);
    io.on('connection', function(socket){
        console.log('connected ' + socket.id);
        socket.on('register', function(data){
            socket.to(data.boardId).emit('register', data.playerId);
        });
        socket.on('move', function(data){
            socket.to(data.boardId).emit('move', {
                "playerId": data.playerId,
                "direction": data.direction
            });
        });
    });

    return io;
}