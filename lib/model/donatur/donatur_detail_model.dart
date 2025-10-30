class DonaturDetailModel {
    final int? id;
    final int? teamId;
    final int? provinceId;
    final int? regencyId;
    final int? districtId;
    final String? uuid;
    final String? qr;
    final String? name;
    final String? phoneNumber;
    final String? address;
    final String? lat;
    final String? lng;
    final String? status;
    final String? createdAt;
    final String? updatedAt;
    final String? deletedAt;
    final String? donationsSumAmount;
    final String? qrUrl;
    final Team? team;
    final Province? province;
    final Regency? regency;
    final District? district;
    final List<Donation>? donations;

    DonaturDetailModel({
        this.id,
        this.teamId,
        this.provinceId,
        this.regencyId,
        this.districtId,
        this.uuid,
        this.qr,
        this.name,
        this.phoneNumber,
        this.address,
        this.lat,
        this.lng,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.donationsSumAmount,
        this.qrUrl,
        this.team,
        this.province,
        this.regency,
        this.district,
        this.donations,
    });

    factory DonaturDetailModel.fromJson(Map<String, dynamic> json) => DonaturDetailModel(
        id: json["id"],
        teamId: json["team_id"],
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        districtId: json["district_id"],
        uuid: json["uuid"],
        qr: json["qr"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        donationsSumAmount: json["donations_sum_amount"],
        qrUrl: json["qr_url"],
        team: Team.fromJson(json["team"]),
        province: Province.fromJson(json["province"]),
        regency: Regency.fromJson(json["regency"]),
        district: District.fromJson(json["district"]),
        donations: List<Donation>.from(json["donations"].map((x) => Donation.fromJson(x))),
    );
}

class District {
    final int? id;
    final int? regencyId;
    final String? name;

    District({
        this.id,
        this.regencyId,
        this.name,
    });

    factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
    );
}

class Donation {
    final int? id;
    final int? donorId;
    final String? receiptUid;
    final String? recipient;
    final String? type;
    final int? amount;
    final String? note;
    final String? createdAt;
    final String? updatedAt;

    Donation({
        this.id,
        this.donorId,
        this.receiptUid,
        this.recipient,
        this.type,
        this.amount,
        this.note,
        this.createdAt,
        this.updatedAt,
    });

    factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        id: json["id"],
        donorId: json["donor_id"],
        receiptUid: json["receipt_uid"],
        recipient: json["recipient"],
        type: json["type"],
        amount: json["amount"],
        note: json["note"],
        createdAt:json["created_at"],
        updatedAt:json["updated_at"],
    );
    
}

class Province {
    final int? id;
    final String? name;

    Province({
        this.id,
        this.name,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
    );
}

class Regency {
    final int? id;
    final int? provinceId;
    final String? name;

    Regency({
        this.id,
        this.provinceId,
        this.name,
    });

    factory Regency.fromJson(Map<String, dynamic> json) => Regency(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
    );
}

class Team {
    final int? id;
    final String? name;
    final String? uuid;
    final String? createdAt;
    final String? updatedAt;
    final String? deletedAt;

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

}
