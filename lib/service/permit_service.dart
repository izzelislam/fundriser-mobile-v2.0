import 'dart:convert';

import 'package:fundriser/model/permit/permit_data_model.dart';
import 'package:fundriser/model/permit/permit_form_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/method.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;

class PermitService {
  
  Future<List<PermitDataModel>> getAllPermit ({String? month = null}) async {
    try {
      final newMonth = month == null ? getCurrentMonthNumber() : month;
      Uri url = Uri.parse('$baseUrl/permits?month=$newMonth');
      final headers = await credential();

      final res = await http.get(url, headers: headers);
      
      if (res.statusCode == 200) {
        return List<PermitDataModel>.from(jsonDecode(res.body)["data"].map((x) => PermitDataModel.fromJson(x)));
      } else {
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }

  }

  Future<PermitDataModel> findPermit(String uuid) async {
    try {
      Uri url = Uri.parse('$baseUrl/permits/$uuid');
      final headers = await credential();

      final res = await http.get(url, headers: headers);
      
      if (res.statusCode == 200) {
        return PermitDataModel.fromJson(jsonDecode(res.body));
      } else {
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PermitDataModel> createPermit(PermitFormModel data) async {
    try {
      Uri url = Uri.parse('$baseUrl/permits');
      final headers = await credential();

      final res = await http.post(url, headers: headers, body: data.toJson());

      if (res.statusCode == 200) {
        return PermitDataModel.fromJson(jsonDecode(res.body)["data"]);
      } else {
        throw jsonDecode(res.body)["message"] ?? jsonDecode(res.body)["error"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deletePermit(String id) async {
    try {
      Uri url = Uri.parse('$baseUrl/permits/$id');
      final headers = await credential();

      final res = await http.delete(url, headers: headers);
      if (res.statusCode == 200) {
        return true;
      } else {
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