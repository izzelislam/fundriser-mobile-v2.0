class DonationFormModel {
    final String? uuid;
    final String? amount;
    final String? type;
    final String? note;

    DonationFormModel({
        this.uuid,
        this.amount,
        this.type,
        this.note,
    });

    DonationFormModel copyWith({
        String? uuid,
        String? amount,
        String? type,
        String? note,
    }) => 
        DonationFormModel(
            uuid: uuid ?? this.uuid,
            amount: amount ?? this.amount,
            type: type ?? this.type,
            note: note ?? this.note,
        );

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
