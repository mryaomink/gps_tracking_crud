import 'package:flutter/material.dart';
import '../models/barang.dart';

class YaoBarang extends StatefulWidget {
  const YaoBarang({super.key});

  @override
  State<YaoBarang> createState() => _YaoBarangState();
}

class _YaoBarangState extends State<YaoBarang> {
  List<Barang> barangList = [
    Barang(id: '1', jenisGPS: 'KL - Advance', imei: '123456789'),
    Barang(id: '2', jenisGPS: 'KL - 1', imei: '987654321'),
    Barang(id: '3', jenisGPS: 'KL - 2', imei: '456789123'),
  ];

  void _showFormDialog({Barang? barang}) {
    final _formKey = GlobalKey<FormState>();
    String jenisGPS = barang?.jenisGPS ?? '';
    String imei = barang?.imei ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            barang == null ? 'Tambah Barang' : 'Edit Barang',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purpleAccent,
            ),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: jenisGPS.isNotEmpty ? jenisGPS : null,
                  items: [
                    'KL - Advance',
                    'KL - 1',
                    'KL - 2',
                    'KL - 3',
                    'KL - 4',
                    'KL - STEALTH',
                    'KL - TUYUL'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    jenisGPS = value!;
                  },
                  decoration: InputDecoration(
                    labelText: 'Jenis GPS',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? 'Pilih jenis GPS' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: imei,
                  decoration: InputDecoration(
                    labelText: 'IMEI',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    imei = value;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'IMEI tidak boleh kosong' : null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (barang == null) {
                    // Tambah barang baru
                    setState(() {
                      barangList.add(Barang(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        jenisGPS: jenisGPS,
                        imei: imei,
                      ));
                    });
                  } else {
                    // Edit barang yang ada
                    setState(() {
                      barang.jenisGPS = jenisGPS;
                      barang.imei = imei;
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteBarang(Barang barang) {
    setState(() {
      barangList.remove(barang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Data Barang',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final barang = barangList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    barang.jenisGPS,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  subtitle: Text('IMEI: ${barang.imei}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.purpleAccent),
                        onPressed: () => _showFormDialog(barang: barang),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deleteBarang(barang),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showFormDialog(),
          backgroundColor: Colors.purpleAccent,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
