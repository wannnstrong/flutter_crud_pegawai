import 'dart:convert';
import 'dart:developer';

import 'package:crud_pegawai/res/res_get_pegawai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_pegawai.dart';
import 'constants.dart';
import 'detail_pegawai.dart';

void main() {
  runApp(MaterialApp(
    home: ListPegawai(),
  ));
}

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  List<DataPegawai> listData = [];
  bool isLoading = false;

  Future deleteData(String? id) async {
    setState(() {
      isLoading = true;
    });
    var res = await http.post(Uri.parse(hapusPegawai), body: {
      'idPegawai': '$id',
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

  Future<DataPegawai?> getPegawai() async {
    var res = await http.post(Uri.parse(listPegawai));
    List<DataPegawai>? data = resGetPegawaiFromJson(res.body).data;
    setState(() {
      listData = data!;
      log('${listData}');
    });
  }

  @override
  void initState() {
    getPegawai();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pegawai'),
      ),
      body: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            DataPegawai data = listData[index];
            return ListTile(
              trailing: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : IconButton(
                      onPressed: () {
                        deleteData(data.id);
                      },
                      icon: Icon(Icons.restore_from_trash),
                    ),
              title: Text('${data.nama}'),
              subtitle: Text('${data.posisi}'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DetailPegawai(data)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddPegawai()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
