import 'package:flutter/material.dart';

class YaoInstalasi extends StatefulWidget {
  const YaoInstalasi({super.key});

  @override
  State<YaoInstalasi> createState() => _YaoInstalasiState();
}

class _YaoInstalasiState extends State<YaoInstalasi> {
  final List<Map<String, String>> _installations = [];
  final List<String> _konsumenList = ['Yaomink', 'Arif', 'Lisa'];
  String? _selectedKonsumen;

  final List<String> _jenisGpsList = [
    'KL-Advance',
    'KL-1',
    'KL-2',
    'KL-3',
    'KL-4',
    'KL-Stealth',
    'KL-Tuyul'
  ];
  String? _jenisKendaraan;
  final List<String> _jenisKendaraanList = [
    // Daftar jenis kendaraan
    'Motor',
    'Mobil',
    'Truk',
    'Bus',
  ];
  String? _selectedJenisGps;

  final List<String> _paketBulananList = ['35rb', '100rb', 'Server Tahunan'];
  String? _selectedPaketBulanan;

  final TextEditingController _jenisKendaraanController =
      TextEditingController();
  final TextEditingController _platNomorController = TextEditingController();
  final TextEditingController _imeiController = TextEditingController();
  final TextEditingController _nomorKartuController = TextEditingController();

  int? _editingIndex;

  @override
  void dispose() {
    _jenisKendaraanController.dispose();
    _platNomorController.dispose();
    _imeiController.dispose();
    _nomorKartuController.dispose();
    super.dispose();
  }

  void _addOrUpdateInstallation() {
    final newInstallation = {
      'konsumen': _selectedKonsumen ?? '',
      'jenisKendaraan': _jenisKendaraan ?? '',
      'platNomor': _platNomorController.text,
      'jenisGps': _selectedJenisGps ?? '',
      'imei': _imeiController.text,
      'nomorKartu': _nomorKartuController.text,
      'paketBulanan': _selectedPaketBulanan ?? '',
    };

    setState(() {
      if (_editingIndex != null) {
        _installations[_editingIndex!] = newInstallation;
        _editingIndex = null;
      } else {
        _installations.add(newInstallation);
      }
      _clearForm();
    });
  }

  void _editInstallation(int index) {
    final installation = _installations[index];
    setState(() {
      _selectedKonsumen = installation['konsumen'];
      _jenisKendaraanController.text = installation['jenisKendaraan'] ?? '';
      _platNomorController.text = installation['platNomor'] ?? '';
      _selectedJenisGps = installation['jenisGps'];
      _imeiController.text = installation['imei'] ?? '';
      _nomorKartuController.text = installation['nomorKartu'] ?? '';
      _selectedPaketBulanan = installation['paketBulanan'];
      _editingIndex = index;
    });
  }

  void _deleteInstallation(int index) {
    setState(() {
      _installations.removeAt(index);
    });
  }

  void _clearForm() {
    _selectedKonsumen = null;
    _jenisKendaraanController.clear();
    _platNomorController.clear();
    _selectedJenisGps = null;
    _imeiController.clear();
    _nomorKartuController.clear();
    _selectedPaketBulanan = null;
  }

  void _showInstallationDetails(Map<String, String> installation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detail Instalasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow('Konsumen', installation['konsumen'] ?? ''),
                _buildDetailRow(
                    'Jenis Kendaraan', installation['jenisKendaraan'] ?? ''),
                _buildDetailRow('Plat Nomor', installation['platNomor'] ?? ''),
                _buildDetailRow('Jenis GPS', installation['jenisGps'] ?? ''),
                _buildDetailRow('IMEI', installation['imei'] ?? ''),
                _buildDetailRow(
                    'Nomor Kartu', installation['nomorKartu'] ?? ''),
                _buildDetailRow(
                    'Paket Bulanan', installation['paketBulanan'] ?? ''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instalasi'),
        backgroundColor: Colors.orangeAccent, // Warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(
                  _konsumenList, _selectedKonsumen, 'Pilih Nama Konsumen',
                  (String? newValue) {
                setState(() {
                  _selectedKonsumen = newValue;
                });
              }),
              const SizedBox(height: 16.0), // Menambahkan jarak antar elemen
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
              const SizedBox(height: 16.0),
              _buildTextField(_platNomorController, 'Plat Nomor'),
              const SizedBox(height: 16.0),
              _buildDropdown(
                  _jenisGpsList, _selectedJenisGps, 'Pilih Jenis GPS',
                  (String? newValue) {
                setState(() {
                  _selectedJenisGps = newValue;
                });
              }),
              const SizedBox(height: 16.0),
              _buildTextField(_imeiController, 'Nomor IMEI'),
              const SizedBox(height: 16.0),
              _buildTextField(_nomorKartuController, 'Nomor Kartu'),
              const SizedBox(height: 30.0),
              const Text(
                'Pilih Paket Bulanan',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent, // Warna teks yang menarik
                ),
              ),
              const SizedBox(height: 16.0),
              _buildChoiceChips(),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _addOrUpdateInstallation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.orangeAccent, // Warna tombol
                ),
                child: Text(
                  _editingIndex == null
                      ? 'Tambah Instalasi'
                      : 'Update Instalasi',
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 300.0,
                child: ListView.builder(
                  itemCount: _installations.length,
                  itemBuilder: (context, index) {
                    final installation = _installations[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          'Konsumen: ${installation['konsumen']}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        subtitle:
                            Text('Jenis GPS: ${installation['jenisGps']}'),
                        onTap: () => _showInstallationDetails(installation),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blueAccent),
                              onPressed: () => _editInstallation(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                              onPressed: () => _deleteInstallation(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildDropdown(List<String> items, String? selectedValue, String hint,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: Text(hint),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildChoiceChips() {
    return Wrap(
      spacing: 8.0,
      children: _paketBulananList.map((String choice) {
        return ChoiceChip(
          label: Text(choice),
          selectedColor: Colors.orangeAccent,
          disabledColor: Colors.grey,
          selected: _selectedPaketBulanan == choice,
          onSelected: (bool selected) {
            setState(() {
              _selectedPaketBulanan = selected ? choice : null;
            });
          },
        );
      }).toList(),
    );
  }
}
