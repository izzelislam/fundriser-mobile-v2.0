import 'dart:convert';

import 'package:fundriser/model/donatur/donatur_data_model.dart';
import 'package:fundriser/model/donatur/donatur_detail_model.dart';
import 'package:fundriser/model/donatur/donatur_form_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;

class DonaturService {

  Future<List<DonaturDataModel>> getAllDonatur({String page = '1'}) async {
    try {
      final token = await AuthService().getCredential();
      Uri url = Uri.parse('$baseUrl/donors?page=$page');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        return List<DonaturDataModel>.from(jsonDecode(res.body)["data"]["data"].map((x) => DonaturDataModel.fromJson(x)));
      }else{
        throw jsonDecode(res.body)["error"];
      }

    } catch (e) {
      print('error di donaturrr service  $e');
      rethrow;
    }
  }

  Future<DonaturDetailModel> findDonatur(String uuid) async {
    try {
      final token = await AuthService().getCredential();
      Uri url = Uri.parse('$baseUrl/donors/$uuid');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        return DonaturDetailModel.fromJson(jsonDecode(res.body)["data"]);
      }else{
        throw jsonDecode(res.body)["error"];
      }

    } catch (e) {
      print('error di donaturrr service 1  $e');
      rethrow;
    }
  }

  Future createDonatur(DonaturFormModel data) async {
    try {
      final token = await AuthService().getCredential();
      Uri url = Uri.parse('$baseUrl/donors');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final res = await http.post(url, headers: headers, body: jsonEncode(data));
      if (res.statusCode == 200) {
        return true;
      }else{
        throw jsonDecode(res.body)["error"];
      }

    } catch (e) {
      print('error di donaturrr service 3 $e');
      rethrow;
    }
  }

  Future deleteDonatur(String uuid) async {
    try {
      final token = await AuthService().getCredential();
      Uri url = Uri.parse('$baseUrl/donors/$uuid');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final res = await http.delete(url, headers: headers);
      if (res.statusCode == 200) {
        return true;
      }else{
        throw jsonDecode(res.body)["error"];
      }

    } catch (e) {
      print('error di donaturrr service 4 $e');
      rethrow;
    }
  }

  Future updateDonatur(String uuid, DonaturFormModel data) async {
    try {
      final token = await AuthService().getCredential();
      Uri url = Uri.parse('$baseUrl/donors/$uuid');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final res = await http.put(url, headers: headers, body: jsonEncode(data));
      if (res.statusCode == 200) {
        return true;
      }else{
        throw jsonDecode(res.body)["error"];
      }

    } catch (e) {
      print('error di donaturrr service 5 $e');
      rethrow;
    }
  } 
  
}