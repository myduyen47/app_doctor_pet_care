class imageModel {
  String id;
  String filename;
  String path;

  imageModel({
    required this.id,
    required this.filename,
    required this.path,
  });

  factory imageModel.fromJson(Map<String, dynamic> json) => imageModel(
        id: json["_id"],
        filename: json["filename"],
        path: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "link": path,
      };


}
