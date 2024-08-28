// models/instalasi.dart
class Instalasi {
  final String konsumen;
  final String jenisKendaraan;
  final String platNomor;
  final String jenisGPS;
  final String nomorImei;
  final String nomorKartu;
  final String paketBulanan;
  final DateTime tanggal;

  Instalasi({
    required this.konsumen,
    required this.jenisKendaraan,
    required this.platNomor,
    required this.jenisGPS,
    required this.nomorImei,
    required this.nomorKartu,
    required this.paketBulanan,
    required this.tanggal,
  });
}
