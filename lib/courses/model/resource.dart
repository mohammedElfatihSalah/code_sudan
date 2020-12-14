class Resource {
  final String id;
  final String name;
  final String url;
  final String description;
  final String dayId;
  final String type;
  final int minutesToComplete;

  Resource(
      {this.type,
      this.id,
      this.name,
      this.url,
      this.description,
      this.dayId,
      this.minutesToComplete});

  static Resource instance(Map resourceJson) {
    String id = resourceJson['_id'];
    String name = resourceJson['name'];
    String description = resourceJson['description'];
    String type = resourceJson['type'];
    String url = resourceJson['url'];
    int minutesToComplete = resourceJson['minutes'];
    return Resource(
        id: id,
        name: name,
        description: description,
        type: type,
        url: url,
        minutesToComplete: minutesToComplete);
  }
}
