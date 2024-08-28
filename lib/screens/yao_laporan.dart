import 'package:flutter/material.dart';

class YaoLaporan extends StatefulWidget {
  const YaoLaporan({super.key});

  @override
  State<YaoLaporan> createState() => _YaoLaporanState();
}

class _YaoLaporanState extends State<YaoLaporan> {
  final List<Map<String, String>> _dataLaporan = [
    {
      'namaKonsumen': 'John Doe',
      'kecamatan': 'Kecamatan A',
      'kota': 'Kota X',
      'provinsi': 'Provinsi Y',
      'jenisKendaraan': 'Motor',
      'platNomor': 'AB 1234 CD',
      'jenisGPS': 'KL-Advance',
      'nomorIMEI': '123456789012345',
      'nomorKartu': 'SIM 1',
      'paketBulanan': 'Paket 35rb',
      'tanggalInstalasi': '2024-08-01',
    },
    {
      'namaKonsumen': 'Jane Smith',
      'kecamatan': 'Kecamatan B',
      'kota': 'Kota Y',
      'provinsi': 'Provinsi Z',
      'jenisKendaraan': 'Mobil',
      'platNomor': 'BC 5678 EF',
      'jenisGPS': 'KL-1',
      'nomorIMEI': '987654321098765',
      'nomorKartu': 'SIM 2',
      'paketBulanan': 'Paket 45rb',
      'tanggalInstalasi': '2024-08-15',
    },
  ];

  List<Map<String, String>> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = _dataLaporan;
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _dataLaporan.where((item) {
        return item.values
            .any((value) => value.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Instalasi Bulanan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(_filteredData));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          final laporan = _filteredData[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLaporanItem(
                    title: 'Nama Konsumen',
                    value: laporan['namaKonsumen'],
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 8.0),
                  _buildLaporanItem(
                    title: 'Kecamatan',
                    value: laporan['kecamatan'],
                    icon: Icons.location_city,
                  ),
                  _buildLaporanItem(
                    title: 'Kota',
                    value: laporan['kota'],
                    icon: Icons.location_on,
                  ),
                  _buildLaporanItem(
                    title: 'Provinsi',
                    value: laporan['provinsi'],
                    icon: Icons.map,
                  ),
                  _buildLaporanItem(
                    title: 'Jenis Kendaraan',
                    value: laporan['jenisKendaraan'],
                    icon: Icons.directions_car,
                  ),
                  _buildLaporanItem(
                    title: 'Plat Nomor',
                    value: laporan['platNomor'],
                    icon: Icons.format_list_numbered,
                  ),
                  _buildLaporanItem(
                    title: 'Jenis GPS',
                    value: laporan['jenisGPS'],
                    icon: Icons.gps_fixed,
                  ),
                  _buildLaporanItem(
                    title: 'Nomor IMEI',
                    value: laporan['nomorIMEI'],
                    icon: Icons.phonelink_setup,
                  ),
                  _buildLaporanItem(
                    title: 'Nomor Kartu',
                    value: laporan['nomorKartu'],
                    icon: Icons.sim_card,
                  ),
                  _buildLaporanItem(
                    title: 'Paket Bulanan',
                    value: laporan['paketBulanan'],
                    icon: Icons.money,
                  ),
                  _buildLaporanItem(
                    title: 'Tanggal Instalasi',
                    value: laporan['tanggalInstalasi'],
                    icon: Icons.calendar_today,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLaporanItem({
    required String title,
    required String? value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            '$title: ${value ?? '-'}',
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}

class DataSearch extends SearchDelegate {
  final List<Map<String, String>> dataLaporan;

  DataSearch(this.dataLaporan);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredData = dataLaporan.where((item) {
      return item.values
          .any((value) => value.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final laporan = filteredData[index];
        return ListTile(
          title: Text(laporan['namaKonsumen'] ?? ''),
          subtitle: Text(laporan['tanggalInstalasi'] ?? ''),
          onTap: () {
            close(context, laporan);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
