class RegencyModel {
    final int? id;
    final String? name;
    final int? provinceId;

    RegencyModel({
        this.id,
        this.name,
        this.provinceId,
    });

    factory RegencyModel.fromJson(Map<String, dynamic> json) => RegencyModel(
        id: json["id"],
        name: json["name"],
        provinceId: json["province_id"],
    );
}