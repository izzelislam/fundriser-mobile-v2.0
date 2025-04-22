import 'dart:convert';

import 'package:fundriser/model/location/district_model.dart';
import 'package:fundriser/model/location/province_model.dart';
import 'package:fundriser/model/location/regency_model.dart';
import 'package:fundriser/service/auth_service.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;

class LocationService{

  Future<List<ProvinceModel>> getProvince() async {
    try {
      Uri url = Uri.parse('$baseUrl/locales/provinces');
      final headers = await credential();

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        return List<ProvinceModel>.from(jsonDecode(res.body)["data"].map((x) => ProvinceModel.fromJson(x)));
      }else{
        throw "Gagal Get Province";
      }

    } catch (e) {
      print('error di location service  $e');
      rethrow;
    }
  }

  Future<List<RegencyModel>> getRegency(String provinceId) async {
    try {
      Uri url = Uri.parse('$baseUrl/locales/province-regencies?province_id=$provinceId');

      final headers  = await credential();

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        return List<RegencyModel>.from(jsonDecode(res.body)["data"].map((x) => RegencyModel.fromJson(x)));
      }else{
        throw "Gagal Get Province";
      }
    } catch (e) {
      print('error di location service 1 $e');
      rethrow;
    }
  }

  Future<List<DistrictModel>> getDistrict(regencyId)  async {
    try {
      Uri url = Uri.parse('$baseUrl/locales/regency-districts?regency_id=$regencyId');

      final headers  = await credential();

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        return List<DistrictModel>.from(jsonDecode(res.body)["data"].map((x) => DistrictModel.fromJson(x)));
      }else{
        throw "Gagal Get Province";
      }
    } catch (e) {
      print('error di location service 2 $e');
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
      print('error di location service 3 $e');
      rethrow;
    }
  }

}