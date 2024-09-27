
class TotalDonationModel {
  final String? total;

  TotalDonationModel({this.total});

  factory TotalDonationModel.fromJson(Map<String, dynamic> json) {
    return TotalDonationModel(
      total: json['data'],
    );
  }
}