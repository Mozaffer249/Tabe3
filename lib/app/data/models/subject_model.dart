class Subject {
  Subject({
    this.id,
    this.name,
    this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
      };
}
