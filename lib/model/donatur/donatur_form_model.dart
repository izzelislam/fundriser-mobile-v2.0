class DonaturFormModel {
    final String? provinceId;
    final String? regencyId;
    final String? districtId;
    final String? name;
    final String? phoneNumber;
    final String? address;
    final String? lat;
    final String? lng;

    DonaturFormModel({
        this.provinceId,
        this.regencyId,
        this.districtId,
        this.name,
        this.phoneNumber,
        this.address,
        this.lat,
        this.lng,
    });

    factory DonaturFormModel.fromJson(Map<String, dynamic> json) => DonaturFormModel(
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        districtId: json["district_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "regency_id": regencyId,
        "district_id": districtId,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
        "lat": lat,
        "lng": lng,
    };
}
