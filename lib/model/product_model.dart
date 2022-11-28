class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  String? typeProduk;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  Produk(
      {this.id,
      this.kodeProduk,
      this.namaProduk,
      this.typeProduk,
      this.createdAt,
      this.updatedAt,
      this.isSelected});

  Produk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeProduk = json['kode_produk'];
    namaProduk = json['nama_produk'];
    typeProduk = json['type_produk'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode_produk'] = kodeProduk;
    data['nama_produk'] = namaProduk;
    data['type_produk'] = typeProduk;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['isSelected'] = false;
    return data;
  }
}
