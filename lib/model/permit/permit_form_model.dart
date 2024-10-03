class PermitFormModel {
    final String? permitAt;
    final String? note;

    PermitFormModel({
        this.permitAt,
        this.note,
    });

    Map<String, dynamic> toJson() => {
        "permit_at": permitAt,
        "note": note,
    };
}
