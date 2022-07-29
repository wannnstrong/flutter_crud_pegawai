import 'package:crud_pegawai/edit_pegawai.dart';
import 'package:crud_pegawai/res/res_get_pegawai.dart';
import 'package:flutter/material.dart';

class DetailPegawai extends StatefulWidget {
  DataPegawai data;
  DetailPegawai(this.data);

  @override
  _DetailPegawaiState createState() => _DetailPegawaiState();
}

class _DetailPegawaiState extends State<DetailPegawai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Detail Pegawai')),
        body: Center(
          child: Column(
            children: [
              Text('${widget.data.nama}'),
              Text('${widget.data.posisi}'),
              Text('${widget.data.gaji}'),
              MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditPegawai(widget.data)));
                  })
            ],
          ),
        ));
  }
}
