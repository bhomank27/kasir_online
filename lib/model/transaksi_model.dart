class Transaksi {
  int? id;
  String? id_user;
  double? totalBayar;
  String? tunai;
  String? kembali;
  String? tglTransaksi;
  String? createdAt;
  String? updatedAt;
  String? namaProduk;
  int? jumlah;
  double? hargaProduk;
  String? keterangan;
  bool? isSelected;

  Transaksi(
      {this.id,
      this.id_user,
      this.totalBayar,
      this.tunai,
      this.kembali,
      this.tglTransaksi,
      this.createdAt,
      this.updatedAt,
      this.namaProduk,
      this.jumlah,
      this.hargaProduk,
      this.keterangan,
      this.isSelected});

  Transaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id_user = json['id_user'];
    totalBayar = json['total_bayar'];
    tunai = json['tunai'];
    kembali = json['kembali'];
    tglTransaksi = json['tgl_transaksi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_bayar'] = totalBayar;
    data['tunai'] = tunai;
    data['kembali'] = kembali;
    data['tgl_transaksi'] = tglTransaksi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
