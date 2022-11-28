import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
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
      print(response.body);
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
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/dashboard", (route) => false);
    } else {
      return response.body;
    }
  }
}
