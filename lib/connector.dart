import 'package:socket_io_client/socket_io_client.dart' as IO;

class Connector {
  String serverURL = "http://192.168.43.84:80";
  IO.Socket socket;
  connectToServer(final Function inCallback) {
    print('>>>>>>>>>>>>>>> called <<<<<<<<<<<<<<<<<');
    socket = IO.io(
        serverURL,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('newPost', (data) => print("post is created"));
    socket.onDisconnect((_) => print('disconnect ho'));
    socket.on('fromServer', (_) => print(_));
  }
}
