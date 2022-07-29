import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'main.dart';

class AddPegawai extends StatefulWidget {
  @override
  _AddPegawaiState createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {
  TextEditingController nama = TextEditingController();
  TextEditingController posisi = TextEditingController();
  TextEditingController gaji = TextEditingController();

  bool isLoading = false;
  Future insertData() async {
    setState(() {
      isLoading = true;
    });
    var res = await http.post(Uri.parse(addPegawai), body: {
      'namaPegawai': nama.text,
      'posisiPegawai': posisi.text,
      'gajiPegawai': gaji.text,
    });
    var data = jsonDecode(res.body);
    if (data['is_success'] == true) {
      setState(() {
        isLoading = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => ListPegawai()), (route) => false);
      });
    } else {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${data['message']}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Pegawai'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
                      onPressed: () {
                        insertData();
                      },
                      child: Text('Save'),
                    ),
            ],
          ),
        ));
  }
}
