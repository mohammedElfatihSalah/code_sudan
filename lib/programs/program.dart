class Program {
  final String name;
  final String description;
  final String imageUrl;
  final String formUrl;

  Program({this.name, this.description, this.imageUrl, this.formUrl});

  static Program instance(Map programJson) {
    String name = programJson['name'];
    String formUrl = programJson['formUrl'];
    String description = programJson['description'];

    return Program(name: name, description: description, formUrl: formUrl);
  }
}
