class DataTransaksi {
  DataTransaksi({
    required this.tanggal,
    required this.pukul,
    required this.namaBarang,
    required this.harga,
    required this.banyakBarang,
    required this.total,
    required this.keterangan,
    required this.isSelected,
  });

  String tanggal;
  String pukul;
  String namaBarang;
  double harga;
  int banyakBarang;
  int total;
  String keterangan;
  bool isSelected;
}
