class LoginSuccess {
    String? token;
    String? type;
    User? user;

    LoginSuccess({
        this.token,
        this.type,
        this.user,
    });

    factory LoginSuccess.fromJson(Map<String, dynamic> json) => LoginSuccess(
        token: json["token"],
        type: json["type"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
        "user": user?.toJson(),
    };
}

class User {
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

    User({
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
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "name": name,
        "image": image,
        "email": email,
        "phone_number": phoneNumber,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "image_url": imageUrl,
    };
}