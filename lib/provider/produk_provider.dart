import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/model/product_model.dart';

import '../storage/storage.dart';

class ProdukProvider extends ChangeNotifier {
  var storage = SecureStorage();

  int totalItem = 0;
  get produk => totalItem;

  addProduk(kode, name, type, hargaUmum, hargaGrosir, context) async {
    var id = await storage.read('id');
    var token = await storage.read('token');
    var url = Uri.parse('$baseUrl/produk');

    var response = await http.post(url, body: {
      "id_user": id,
      "kode": kode,
      "nama": name,
      "type": type,
      "harga_umum": hargaUmum,
      "harga_grosir": hargaGrosir,
    }, headers: {
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 201) {
      getProduk();
      Navigator.pop(context);
    }
    notifyListeners();
  }

  getProduk() async {
    var token = await storage.read('token');
    var url = Uri.parse('$baseUrl/produk');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];

      List<Produk> produk = data.map((e) => Produk.fromJson(e)).toList();
      return produk;
    } else {
      <Produk>[];
    }
    notifyListeners();
  }

  Future<Produk> getProdukByBarcode(barcode) async {
    var url = Uri.parse('$baseUrl/produk');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      Produk? produk;
      List<Produk> data = json.decode(response.body)['data'];
      data.map((Produk data) {
        if (barcode == data.kodeProduk) {
          produk = data;
        } else {
          return {};
        }
      });
      return produk!;
    }
    notifyListeners();
    return Produk();
  }
}
