class ProfileModel {
    int? id;
    String? teamId;
    String? name;
    String? image;
    String? email;
    String? phoneNumber;
    String? emailVerifiedAt;
    String? role;
    String? status;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;
    String? imageUrl;
    Team? team;

    ProfileModel({
        this.id,
        this.teamId,
        this.name,
        this.image,
        this.email,
        this.phoneNumber,
        this.emailVerifiedAt,
        this.role,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.imageUrl,
        this.team,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        teamId: json["team_id"],
        name: json["name"],
        image: json["image"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        imageUrl: json["image_url"],
        team: json["team"] != null ? Team.fromJson(json["team"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "team_id": teamId ?? '',
        "name": name ?? '',
        "image": image ?? '',
        "email": email ?? '',
        "phone_number": phoneNumber ?? '',
        "email_verified_at": emailVerifiedAt ?? '',
        "role": role ?? '',
        "status": status ?? '',
        "created_at": createdAt ?? '',
        "updated_at": updatedAt ?? '',
        "deleted_at": deletedAt ?? '',
        "image_url": imageUrl ?? '',
        "team": team != null ? team!.toJson() : '',
    };
}

class Team {
    int? id;
    String? name;
    String? uuid;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;

    Team({
        this.id,
        this.name,
        this.uuid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        uuid: json["uuid"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "name": name ?? '',
        "uuid": uuid ?? '',
        "created_at": createdAt ?? '',
        "updated_at": updatedAt ?? '',
        "deleted_at": deletedAt ?? '',
    };
}
