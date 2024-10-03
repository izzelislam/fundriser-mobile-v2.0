class PresentModel {
    final int? id;
    // final String? userId;
    final String? presentAt;
    final String? type;
    final String? note;
    final String? lat;
    final String? long;
    final String? createdAt;
    final String? updatedAt;

    PresentModel({
        this.id,
        // this.userId,
        this.presentAt,
        this.type,
        this.note,
        this.lat,
        this.long,
        this.createdAt,
        this.updatedAt,
    });

    factory PresentModel.fromJson(Map<String, dynamic> json) => PresentModel(
        id: json["id"],
        // userId: json["user_id"],
        presentAt: json["present_at"],
        type: json["type"],
        note: json["note"],
        lat: json["lat"],
        long: json["long"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        // "user_id": userId,
        "type": type,
        "note": note,
        "lat": lat,
        "long": long,
    };
}