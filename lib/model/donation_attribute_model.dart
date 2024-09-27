class DonationAttributeModel {
    final int? currentPage;
    final int? from;
    final int? lastPage;
    final int? perPage;
    final int? to;
    final int? total;

    DonationAttributeModel({
        this.currentPage,
        this.from,
        this.lastPage,
        this.perPage,
        this.to,
        this.total,
    });

    factory DonationAttributeModel.fromJson(Map<String, dynamic> json) => DonationAttributeModel(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "per_page": perPage,
        "to": to,
        "total": total,
    };
}
