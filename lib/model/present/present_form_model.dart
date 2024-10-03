class PresentFormModel {
    final String? type;
    final String? note;
    final String? lat;
    final String? long;

    PresentFormModel({
        this.type,
        this.note,
        this.lat,
        this.long,
    });

    Map<String, dynamic> toJson() => {
        "type": type,
        "note": note,
        "lat": lat,
        "long": long,
    };
}
