class DistrictModel {
    final int? id;
    final String? name;
    final int? regencyId;

    DistrictModel({
        this.id,
        this.name,
        this.regencyId,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json["id"],
        name: json["name"],
        regencyId: json["regency_id"],
    );
}