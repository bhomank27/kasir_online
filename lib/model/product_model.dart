class Produk {
  int? id;
  String? idProduk;
  String? kodeProduk;
  String? namaProduk;
  int? jumlah;
  String? typeProduk;
  String? hargaUmum;
  String? hargaGrosir;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  Produk(
      {this.id,
      this.idProduk,
      this.kodeProduk,
      this.namaProduk,
      this.jumlah,
      this.typeProduk,
      this.hargaUmum,
      this.hargaGrosir,
      this.createdAt,
      this.updatedAt,
      this.isSelected});

  Produk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduk = json['id_produk'];
    kodeProduk = json['kode_produk'];
    namaProduk = json['nama_produk'];
    typeProduk = json['type_produk'];
    hargaUmum = json['harga_umum'];
    hargaGrosir = json['harga_grosir'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_produk'] = idProduk;
    data['kode_produk'] = kodeProduk;
    data['nama_produk'] = namaProduk;
    data['type_produk'] = typeProduk;
    data['harga_umum'] = hargaUmum;
    data['harga_grosir'] = hargaGrosir;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
