import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/model/transaksi_model.dart';
import 'package:kasir_online/storage/storage.dart';

class TransaksiProvider extends ChangeNotifier {
  var storage = SecureStorage();

  addTransaksi(totalBayar, tunai, kembali) async {
    var token = await storage.read('token');
    var id = await storage.read('id');
    var url = Uri.parse("$baseUrl/transaksi");
    DateTime today = DateTime.now();

    var response = await http.post(url, body: {
      'id_user': id,
      'total_bayar': totalBayar,
      'tunai': tunai,
      'kembali': kembali,
      'tgl_transaksi': today.toString(),
    }, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 201) {}
  }

  getTransaksi() async {
    var token = await storage.read('token');
    var url = Uri.parse("$baseUrl/transaksi");

    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data']['data'];
      List<Transaksi> transaksi =
          data.map((e) => Transaksi.fromJson(e)).toList();

      return data;
    }
  }
}
