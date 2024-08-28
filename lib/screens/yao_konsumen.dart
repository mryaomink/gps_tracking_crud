import 'package:app_data/screens/yao_add_konsumen.dart';
import 'package:flutter/material.dart';

import '../models/konsumen.dart';

class YaoKonsumen extends StatefulWidget {
  const YaoKonsumen({super.key});

  @override
  State<YaoKonsumen> createState() => _YaoKonsumenState();
}

class _YaoKonsumenState extends State<YaoKonsumen> {
  final List<Konsumen> konsumenList = [
    // Tambahkan lebih banyak konsumen sesuai kebutuhan
  ];

  void tambahKonsumen(Konsumen konsumen) {
    setState(() {
      konsumenList.add(konsumen);
    });
  }

  void editKonsumen(int index, Konsumen konsumen) {
    setState(() {
      konsumenList[index] = konsumen;
    });
  }

  void hapusKonsumen(int index) {
    setState(() {
      konsumenList.removeAt(index);
    });
  }

  void tampilkanDetailKonsumen(
      BuildContext context, Konsumen konsumen, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(konsumen.nama),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Alamat', konsumen.alamat),
                  _buildDetailItem('No. HP', konsumen.noHp),
                  _buildDetailItem('Jenis Kendaraan', konsumen.jenisKendaraan),
                  _buildDetailItem('Plat Nomor', konsumen.platNomor),
                  _buildDetailItem('Jenis GPS', konsumen.jenisGPS),
                  _buildDetailItem('Nomor IMEI', konsumen.nomorImei),
                  _buildDetailItem('Nomor Kartu', konsumen.nomorKartu),
                  _buildDetailItem('Paket Bulanan', konsumen.paketBulanan),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YaoAddKonsumen(
                      onAdd: (konsumenBaru) {
                        editKonsumen(index, konsumenBaru);
                      },
                      konsumen: konsumen,
                    ),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                hapusKonsumen(index);
                Navigator.pop(context);
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value ?? '-'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Data Konsumen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: konsumenList.length,
        itemBuilder: (context, index) {
          final konsumen = konsumenList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              leading: Icon(
                konsumen.jenisKendaraan == 'Mobil'
                    ? Icons.directions_car
                    : konsumen.jenisKendaraan == 'Motor'
                        ? Icons.motorcycle
                        : konsumen.jenisKendaraan == 'Truk'
                            ? Icons.local_shipping
                            : konsumen.jenisKendaraan == 'Bus'
                                ? Icons.bus_alert
                                : Icons.help,
                color: Colors.teal,
              ),
              title: Text(konsumen.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(konsumen.alamat),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
              onTap: () {
                tampilkanDetailKonsumen(context, konsumen, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YaoAddKonsumen(
                onAdd: tambahKonsumen,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
