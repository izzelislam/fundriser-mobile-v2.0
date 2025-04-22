import 'dart:convert';

import 'package:fundriser/model/login_model.dart';
import 'package:fundriser/model/login_success_model.dart';
import 'package:fundriser/model/profile_model.dart';
import 'package:fundriser/shared/variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService{
  Future login(LoginModel data) async {
    try {
      Uri url = Uri.parse('$baseUrl/login');
      final res = await http.post(url, body: data.toJson());

      if (res.statusCode == 200) {
        LoginSuccess loginSuccess = LoginSuccess.fromJson(jsonDecode(res.body)['data']);
        return loginSuccess;
      }{
        throw 'No Telepon atau Password Salah';
      }

    } catch (e) {
      print('error di login service $e');
      rethrow;
    }
  }

  Future<void> saveCredential(String token) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: token);
    } catch (e) {
      print('error di login service 2 $e');
      rethrow;
    }
  }

  Future<String?> getCredential() async {
    try {
      const storage = FlutterSecureStorage();
      return await storage.read(key: "token");
    } catch (e) {
      print('error di login service 3$e');
      rethrow;
    }
  }

  Future changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final token = await getCredential();
      Uri url = Uri.parse('$baseUrl/update-password');

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final body = {
        'old_password': oldPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword
      };

      final res = await http.post(url, headers: headers, body: body);
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['message'];
      }else{
        throw jsonDecode(res.body)['error'] ?? jsonDecode(res.body)['error']["password"];
      }

    } catch (e) {
      print('error di login service 4 $e');
      rethrow;
    }
  }

  Future logOut() async {
    try {
      
      final token = await getCredential();
      Uri url = Uri.parse('$baseUrl/logout');
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final res = await http.post(url, headers: headers);
      if (res.statusCode == 200) {
        await deleteCredential();
        return true;
      }else{
        throw 'Gagal Logout';
      }

    } catch (e) {
      print('error di login service 5 $e');
      rethrow;
    }
  }

  Future<void> deleteCredential() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: "token");
    } catch (e) {
      print('error di login service 6 $e');
      rethrow;
    }
  }

  Future<ProfileModel> getProfile() async {
    try {
      final token = await getCredential();
      Uri url = Uri.parse('$baseUrl/me');

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(res.body)['data']);
        return profileModel;
      }else{
        throw 'Gagal Get Profile';
      }

    } catch (e) {
      print('error di login service 7 $e');
      rethrow;
    }
  }
}