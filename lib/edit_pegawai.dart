import 'package:crud_pegawai/constants.dart';
import 'package:crud_pegawai/res/res_get_pegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPegawai extends StatefulWidget {
  DataPegawai data;
  EditPegawai(this.data);

  @override
  _EditPegawaiState createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  TextEditingController? nama, posisi, gaji;

  bool isLoading = false;

  Future updateData() async {
    setState(() {
      isLoading = true;
    });

    var res = await http.post(Uri.parse(updatePegawai), body: {
      'namaPegawai': nama?.text,
      'posisiPegawai': posisi?.text,
      'gajiPegawai': gaji?.text,
      'idPegawai': '${widget.data.id}',
    });
  }

  @override
  void initState() {
    nama = TextEditingController(text: widget.data.nama);
    gaji = TextEditingController(text: widget.data.gaji);
    posisi = TextEditingController(text: widget.data.posisi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditPegawai'),
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: nama,
            decoration: InputDecoration(hintText: 'Nama'),
          ),
          TextFormField(
            controller: posisi,
            decoration: InputDecoration(hintText: 'Posisi'),
          ),
          TextFormField(
            controller: gaji,
            decoration: InputDecoration(hintText: 'Gaji'),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    updateData();
                  },
                  child: Text('Edit'),
                )
        ],
      ),
    );
  }
}
