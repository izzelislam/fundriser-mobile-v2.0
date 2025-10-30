import 'package:fundriser/model/location/district_model.dart';
import 'package:fundriser/model/location/province_model.dart';
import 'package:fundriser/model/location/regency_model.dart';

class DonaturDataModel {
    final int? id;
    final int? teamId;
    final int? provinceId;
    final int? regencyId;
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
    final ProvinceModel? province;
    final RegencyModel? regency;
    final DistrictModel? district;
    final String? donationSumAmount;

    DonaturDataModel({
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
        this.province,
        this.regency,
        this.district,
        this.donationSumAmount
    });

    factory DonaturDataModel.fromJson(Map<String, dynamic> json) => DonaturDataModel(
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
        donationSumAmount: json["donations_sum_amount"],
        province: json["province"] != null ? ProvinceModel.fromJson(json["province"]) : null,
        regency: json["regency"] != null ? RegencyModel.fromJson(json["regency"]) : null,
        district: json["district"] != null ? DistrictModel.fromJson(json["district"]) : null,
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
