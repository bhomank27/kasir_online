import 'package:flutter/cupertino.dart';
import 'package:kasir_online/config/baseUrl.dart';
import 'package:http/http.dart' as http;

class TransaksiProvider extends ChangeNotifier {
  addTransaksi(totalBayar, tunai, kembali) async {
    var url = Uri.parse("$baseUrl/transaksi");
    DateTime today = DateTime.now();

    var response = await http.post(url, body: {
      'total_bayar': totalBayar,
      'tunai': tunai,
      'kembali': kembali,
      'tgl_transaksi': today.toString(),
    });

    print(response.body);
    if (response.statusCode == 200) {
      print("BERHASIL TAMBAH TRANSAKSI");
    }
  }
}
