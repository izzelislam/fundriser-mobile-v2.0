class ContentDataModel {
    final int? id;
    final String? title;
    final String? image;
    final String? content;
    final String? createdAt;
    final String? updatedAt;
    final String? imageLink;

    ContentDataModel({
        this.id,
        this.title,
        this.image,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.imageLink,
    });

    factory ContentDataModel.fromJson(Map<String, dynamic> json) => ContentDataModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        content: json["content"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "content": content,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image_link": imageLink,
    };
}
