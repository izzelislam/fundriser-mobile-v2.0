class PermitDataModel {
    final int? id;
    final String? permitAt;
    final String? note;
    final String? createdAt;
    final String? updatedAt;

    PermitDataModel({
        this.id,
        this.permitAt,
        this.note,
        this.createdAt,
        this.updatedAt,
    });

    factory PermitDataModel.fromJson(Map<String, dynamic> json) => PermitDataModel(
        id: json["id"],
        permitAt: json["permit_at"],
        note: json["note"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "permit_at": permitAt,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
