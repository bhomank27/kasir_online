import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:kasir_online/model/product_model.dart';

import '../storage/storage.dart';

class ProdukProvider extends ChangeNotifier {
  var storage = SecureStorage();

  List<Produk> allProduk = [];
  List allKategori = [];

  get produk => allProduk;
  get kategori => allKategori;

  getKategori() {
    allKategori = [];
    for (var item in allProduk) {
      allKategori.add(item.typeProduk);
    }
    allKategori = kategori.toSet().toList();
    notifyListeners();
  }

  addProduk(kode, name, type, hargaUmum, hargaGrosir) async {
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
    } else {}
    notifyListeners();
  }

  getProduk() async {
    var token = await storage.read('token');
    var url = Uri.parse('$baseUrl/produk');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      allProduk = data.map((e) => Produk.fromJson(e)).toList();
    } else {
      <Produk>[];
    }
    notifyListeners();
  }

  Future<Produk> getProdukByBarcode(barcode) async {
    var token = await storage.read('token');
    var url = Uri.parse('$baseUrl/produk');
    Produk? produk;
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      for (var i in data) {
        if (barcode == i['kode']) {
          print(i);
          produk = Produk(
            id: i['id'],
            namaProduk: i['nama'],
            hargaUmum: i['harga_umum'],
            typeProduk: i['type'],
          );
        }
      }
      return produk!;
    }
    return Produk();
  }
}
