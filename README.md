Demo: https://webhockey.herokuapp.com/board

# How to play
The WebHockey is a web game for two players. The board for the game is hosted on the website. A player can play the game in two ways: 

* using smartphone's sensors - read the QR code and go to the website (this method requires the ability to read the sensor's data in phone, more information can be found at this link: https://developer.mozilla.org/en-US/docs/Web/API/Detecting_device_orientation)
* using arrows on the keyboard - click on the QR code, a new page will open. Use left and right arrows to control.

To start the game click on the pitch.

# Technical details
The backend is implemented using the Node.js framework with the socket.io library. The board and players are clients and communicate with each other using the websocket protocol. The pitch is implemented using the Processing.js library and HTML5 features.
