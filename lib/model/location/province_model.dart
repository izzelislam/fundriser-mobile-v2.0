class ProvinceModel {
    final int? id;
    final String? name;

    ProvinceModel({
        this.id,
        this.name,
    });

    factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json["id"],
        name: json["name"],
    );
}
