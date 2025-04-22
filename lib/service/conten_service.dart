import 'dart:convert';

import 'package:fundriser/model/content_data_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;

class ContentService{

  Future<List<ContentDataModel>> getAllContent() async {
    try {
        final token = await AuthService().getCredential();
        Uri url = Uri.parse('$baseUrl/contents');
        final headers = {
          'Authorization': 'Bearer $token',
        };

        final res = await http.get(url, headers: headers);  

        if (res.statusCode == 200) {
          return List<ContentDataModel>.from(jsonDecode(res.body)["data"]["data"].map((x) => ContentDataModel.fromJson(x)));
        }else{
          throw "gagal get content";
        }

    } catch (e) {
      print('error di content service $e');
      rethrow;
    }
  }

}