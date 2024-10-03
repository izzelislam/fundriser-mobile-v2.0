import 'package:fundriser/model/present/present_form_model.dart';
import 'package:fundriser/model/present/present_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PresentService {

  Future<List<PresentModel>> getPresent() async {
    try {
      Uri url = Uri.parse('$baseUrl/presents');
      final headers = await credential();

      final res = await http.get(url, headers: headers);

      // print(jsonDecode(res.body)["data"]);

      if (res.statusCode == 200) {
        return List<PresentModel>.from(jsonDecode(res.body)["data"].map((x) => PresentModel.fromJson(x)));
      }else{
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createPresent(PresentFormModel data) async {
    try {
      Uri url = Uri.parse('$baseUrl/presents');
      final headers = await credential();

      final res = await http.post(url, headers: headers, body: data.toJson());


      if (res.statusCode == 200) {
        return PresentModel.fromJson(jsonDecode(res.body)["data"]);
      }else{
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deletePresent(String uuid) async {
    try {
      Uri url = Uri.parse('$baseUrl/presents/$uuid');
      final headers = await credential();

      final res = await http.delete(url, headers: headers);
      if (res.statusCode == 200) {
        return;
      }else{
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  // find
  Future<PresentModel> findPresent(String uuid) async {
    try {
      Uri url = Uri.parse('$baseUrl/presents/$uuid');
      final headers = await credential();

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return PresentModel.fromJson(jsonDecode(res.body)["data"]);
      }else{
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> credential() async {
    try {
      final token = await AuthService().getCredential();
      final headers = {
        'Authorization': 'Bearer $token',
      };
      return headers;
    } catch (e) {
      rethrow;
    }
  }

}