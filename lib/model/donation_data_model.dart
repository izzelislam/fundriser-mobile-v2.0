class DonationDataModel {
    final int? id;
    final String? receiptUid;
    final String? recipient;
    final String? type;
    final dynamic amount;
    final String? note;
    final String? createdAt;
    final String? updatedAt;
    final Donor? donor;

    DonationDataModel({
        this.id,
        this.receiptUid,
        this.recipient,
        this.type,
        this.amount,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.donor,
    });

    factory DonationDataModel.fromJson(Map<String, dynamic> json) => DonationDataModel(
        id: json["id"],
        receiptUid: json["receipt_uid"],
        recipient: json["recipient"],
        type: json["type"],
        amount: json["amount"],
        note: json["note"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        donor: Donor.fromJson(json["donor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "receipt_uid": receiptUid,
        "recipient": recipient,
        "type": type,
        "amount": amount,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "donor": donor?.toJson(),
    };
}

class Donor {
    final int? id;
    final String? teamId;
    final String? provinceId;
    final String? regencyId;
    final String? districtId;
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
    final String? qrUrl;

    Donor({
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
        this.qrUrl,
    });

    factory Donor.fromJson(Map<String, dynamic> json) => Donor(
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
        qrUrl: json["qr_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "province_id": provinceId,
        "regency_id": regencyId,
        "district_id": districtId,
        "uuid": uuid,
        "qr": qr,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "lat": lat,
        "lng": lng,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "qr_url": qrUrl,
    };
}
