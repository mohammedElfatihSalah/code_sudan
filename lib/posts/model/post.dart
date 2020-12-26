class Post {
  final String id;
  final String name;
  final String des;
  final String time;

  Post({this.id, this.name, this.des, this.time});

  String getTime() {
    return 'Dec 23 at 3:04';
  }

  String getContent() {
    return des;
  }

  String getTitle() {
    return name;
  }
}
