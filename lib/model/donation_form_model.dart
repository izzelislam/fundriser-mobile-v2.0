class DonationFormModel {
    final String? uuid;
    final int? amount;
    final String? type;
    final String? note;

    DonationFormModel({
        this.uuid,
        this.amount,
        this.type,
        this.note,
    });

    factory DonationFormModel.fromJson(Map<String, dynamic> json) => DonationFormModel(
        uuid: json["uuid"],
        amount: json["amount"],
        type: json["type"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "amount": amount,
        "type": type,
        "note": note,
    };
}
