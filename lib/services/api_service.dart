import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:firebase_project/screens//constants.dart';
import 'package:firebase_project/model/user_model.dart';

class ApiService {
  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> model = userModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}