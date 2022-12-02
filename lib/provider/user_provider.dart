import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/helper/layout.dart';

import '../storage/storage.dart';

class UserProvider extends ChangeNotifier {
  var storage = SecureStorage();
  signUp(context, name, email, password, passwordConfirm) async {
    var url = Uri.parse('$baseUrl/register');

    var response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirm,
      },
    );

    if (response.statusCode == 201) {
      login(context, email, password);
    } else {
      return response.body;
    }
  }

  login(context, email, password) async {
    var url = Uri.parse('$baseUrl/login');

    var response = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );
    var status = jsonDecode(response.body)['success'];
    if (status) {
      var token = jsonDecode(response.body)['token'];
      var role = jsonDecode(response.body)['user']['role'];
      var id = jsonDecode(response.body)['user']['id'];
      await storage.write('token', token);
      await storage.write('role', role);
      await storage.write('id', id.toString());
      print(token);
      getProfile();
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashboard", (route) => false);
    } else {
      var message = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message,
              style:
                  TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 1.5))));
    }
  }

  getProfile() async {
    var token = await storage.read("token");

    var url = Uri.parse("$baseUrl/profile");
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  logout(context) async {
    try {
      var url = Uri.parse('$baseUrl/logout');
      var token = await storage.read('token');
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token",
      });
      print(response.body);
      await storage.deleteAll();
      Navigator.pushNamedAndRemoveUntil(context, '/signIn', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
