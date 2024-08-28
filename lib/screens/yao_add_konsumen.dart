import 'package:flutter/material.dart';
import '../models/konsumen.dart';

class YaoAddKonsumen extends StatefulWidget {
  final Function(Konsumen) onAdd;
  final Konsumen? konsumen;

  const YaoAddKonsumen({super.key, required this.onAdd, this.konsumen});

  @override
  _YaoAddKonsumenState createState() => _YaoAddKonsumenState();
}

class _YaoAddKonsumenState extends State<YaoAddKonsumen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _noHpController;
  late TextEditingController _platNomorController;
  late TextEditingController _nomorImeiController;
  late TextEditingController _nomorKartuController;

  String? _selectedKota;
  String? _selectedProvinsi;
  String? _selectedKecamatan;

  String? _jenisGps;
  String? _selectedPaket;
  String? _jenisKendaraan; // Tambahkan variabel untuk jenis kendaraan

  final List<String> _jenisGpsList = [
    'KL-Advance',
    'KL-1',
    'KL-2',
    'KL-3',
    'KL-4',
    'KL-Stealth',
    'KL-Tuyul',
  ];

  final List<String> _paketList = [
    '35rb dan Server tahunan 100rb',
    '20rb dan Server bulanan 50rb',
    '50rb dan Server tahunan 200rb',
  ];

  final List<String> _jenisKendaraanList = [
    // Daftar jenis kendaraan
    'Motor',
    'Mobil',
    'Truk',
    'Bus',
  ];

  final List<String> _kotaList = ['Jakarta', 'Bandung', 'Surabaya'];
  final List<String> _provinsiList = [
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Timur'
  ];
  final List<String> _kecamatanList = [
    'Kecamatan A',
    'Kecamatan B',
    'Kecamatan C'
  ];

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller dengan data dari konsumen jika mode edit
    _namaController = TextEditingController(text: widget.konsumen?.nama ?? '');
    _noHpController = TextEditingController(text: widget.konsumen?.noHp ?? '');
    _platNomorController =
        TextEditingController(text: widget.konsumen?.platNomor ?? '');
    _nomorImeiController =
        TextEditingController(text: widget.konsumen?.nomorImei ?? '');
    _nomorKartuController =
        TextEditingController(text: widget.konsumen?.nomorKartu ?? '');

    if (widget.konsumen != null) {
      final alamat = widget.konsumen!.alamat.split(',');
      _selectedKota = alamat[0];
      _selectedProvinsi = alamat[1];
      _selectedKecamatan = alamat[2];
      _jenisKendaraan =
          widget.konsumen!.jenisKendaraan; // Inisialisasi jenis kendaraan
    }

    _jenisGps = widget.konsumen?.jenisGPS;
    _selectedPaket = widget.konsumen?.paketBulanan;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _noHpController.dispose();
    _platNomorController.dispose();
    _nomorImeiController.dispose();
    _nomorKartuController.dispose();
    super.dispose();
  }

  void _saveKonsumen() {
    if (_formKey.currentState?.validate() ?? false) {
      final alamat = '$_selectedKota,$_selectedProvinsi,$_selectedKecamatan';
      final konsumen = Konsumen(
        nama: _namaController.text,
        alamat: alamat,
        noHp: _noHpController.text,
        jenisKendaraan: _jenisKendaraan ?? '', // Simpan jenis kendaraan
        platNomor: _platNomorController.text,
        jenisGPS: _jenisGps ?? '',
        nomorImei: _nomorImeiController.text,
        nomorKartu: _nomorKartuController.text,
        paketBulanan: _selectedPaket ?? '',
      );

      widget.onAdd(konsumen);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          widget.konsumen == null ? 'Tambah Konsumen' : 'Edit Konsumen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedKota,
                items: _kotaList.map((kota) {
                  return DropdownMenuItem(
                    value: kota,
                    child: Text(kota),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKota = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Kota'),
                validator: (value) =>
                    value == null ? 'Kota harus dipilih' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedProvinsi,
                items: _provinsiList.map((provinsi) {
                  return DropdownMenuItem(
                    value: provinsi,
                    child: Text(provinsi),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvinsi = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Provinsi'),
                validator: (value) =>
                    value == null ? 'Provinsi harus dipilih' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedKecamatan,
                items: _kecamatanList.map((kecamatan) {
                  return DropdownMenuItem(
                    value: kecamatan,
                    child: Text(kecamatan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKecamatan = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Kecamatan'),
                validator: (value) =>
                    value == null ? 'Kecamatan harus dipilih' : null,
              ),
              TextFormField(
                controller: _noHpController,
                decoration: const InputDecoration(labelText: 'No HP'),
                validator: (value) =>
                    value!.isEmpty ? 'No HP tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _platNomorController,
                decoration: const InputDecoration(labelText: 'Plat Nomor'),
                validator: (value) =>
                    value!.isEmpty ? 'Plat Nomor tidak boleh kosong' : null,
              ),
              DropdownButtonFormField<String>(
                value: _jenisGps,
                items: _jenisGpsList.map((gps) {
                  return DropdownMenuItem(
                    value: gps,
                    child: Text(gps),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _jenisGps = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Jenis GPS'),
                validator: (value) =>
                    value == null ? 'Jenis GPS harus dipilih' : null,
              ),
              TextFormField(
                controller: _nomorImeiController,
                decoration: const InputDecoration(labelText: 'Nomor IMEI'),
                validator: (value) =>
                    value!.isEmpty ? 'Nomor IMEI tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _nomorKartuController,
                decoration: const InputDecoration(labelText: 'Nomor Kartu'),
                validator: (value) =>
                    value!.isEmpty ? 'Nomor Kartu tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              Text('Pilih Jenis Kendaraan:',
                  style: Theme.of(context).textTheme.titleMedium),
              DropdownButtonFormField<String>(
                value: _jenisKendaraan,
                items: _jenisKendaraanList.map((kendaraan) {
                  return DropdownMenuItem(
                    value: kendaraan,
                    child: Text(kendaraan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _jenisKendaraan = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Jenis Kendaraan'),
                validator: (value) =>
                    value == null ? 'Jenis Kendaraan harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              Text('Pilih Paket Bulanan:',
                  style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8.0,
                children: _paketList.map((paket) {
                  return ChoiceChip(
                    selectedColor: Colors.green,
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    label: Text(
                      paket,
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _selectedPaket == paket,
                    onSelected: (selected) {
                      setState(() {
                        _selectedPaket = selected ? paket : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveKonsumen,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
