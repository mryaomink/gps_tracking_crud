// data/alamat_data.dart
class AlamatData {
  static const List<String> provinsi = [
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    // Tambahkan lebih banyak data provinsi
  ];

  static const Map<String, List<String>> kota = {
    'Jawa Barat': ['Bandung', 'Bekasi', 'Bogor'],
    'Jawa Tengah': ['Semarang', 'Solo', 'Magelang'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Kediri'],
    // Tambahkan lebih banyak data kota
  };

  static const Map<String, List<String>> kecamatan = {
    'Bandung': ['Andir', 'Astanaanyar', 'Bojongloa Kaler'],
    'Bekasi': ['Babelan', 'Bekasi Barat', 'Bekasi Timur'],
    'Bogor': ['Bogor Barat', 'Bogor Selatan', 'Bogor Tengah'],
    'Semarang': ['Banyumanik', 'Candisari', 'Gajahmungkur'],
    'Solo': ['Banjarsari', 'Jebres', 'Laweyan'],
    'Magelang': ['Bandongan', 'Borobudur', 'Candimulyo'],
    'Surabaya': ['Asemrowo', 'Benowo', 'Bubutan'],
    'Malang': ['Blimbing', 'Klojen', 'Lowokwaru'],
    'Kediri': ['Banyakan', 'Gampengrejo', 'Grogol'],
    // Tambahkan lebih banyak data kecamatan
  };
}
