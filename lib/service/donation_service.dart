import 'package:fundriser/model/donation_data_model.dart';
import 'package:fundriser/model/total_donation_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonationService {
    
    Future<TotalDonationModel> getTotalDOnation() async {
      try {
        final token = await AuthService().getCredential();
        Uri url = Uri.parse('$baseUrl/donations/get-total-donation');

        final headers = {
          'Authorization': 'Bearer $token',
        };

        final res = await http.get(url, headers: headers);

        if (res.statusCode == 200) {
          TotalDonationModel totalDonation = TotalDonationModel.fromJson(jsonDecode(res.body));
          return totalDonation;
        }else{
          throw 'Gagal Get Total Donation';
        }
      } catch (e) {
        rethrow;
      }
    }

    Future getAllDonation({String page = '1'}) async {
      try {
        final token = await AuthService().getCredential();
        Uri url = Uri.parse('$baseUrl/donations?page=$page');

        final headers = {
          'Authorization': 'Bearer $token',
        };

        final res = await http.get(url, headers: headers);


        if (res.statusCode == 200) {
          return List<DonationDataModel>.from(jsonDecode(res.body)["data"]["data"].map((x) => DonationDataModel.fromJson(x)));
        }else{
          throw 'Gagal Get Donation Data';
        }
      } catch (e) {
        rethrow;
      }
    }

}