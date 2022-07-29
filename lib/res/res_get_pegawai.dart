// To parse this JSON data, do
//
//     final resGetPegawai = resGetPegawaiFromJson(jsonString);

import 'dart:convert';

ResGetPegawai resGetPegawaiFromJson(String str) => ResGetPegawai.fromJson(json.decode(str));

String resGetPegawaiToJson(ResGetPegawai data) => json.encode(data.toJson());

class ResGetPegawai {
  ResGetPegawai({
    this.isSuccess,
    this.message,
    this.data,
  });

  bool? isSuccess;
  String? message;
  List<DataPegawai>? data;

  factory ResGetPegawai.fromJson(Map<String, dynamic> json) => ResGetPegawai(
    isSuccess: json["is_success"] == null ? null : json["is_success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataPegawai>.from(json["data"].map((x) => DataPegawai.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess == null ? null : isSuccess,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPegawai {
  DataPegawai({
    this.id,
    this.nama,
    this.posisi,
    this.gaji,
  });

  String? id;
  String? nama;
  String? posisi;
  String? gaji;

  factory DataPegawai.fromJson(Map<String, dynamic> json) => DataPegawai(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    posisi: json["posisi"] == null ? null : json["posisi"],
    gaji: json["gaji"] == null ? null : json["gaji"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama": nama == null ? null : nama,
    "posisi": posisi == null ? null : posisi,
    "gaji": gaji == null ? null : gaji,
  };
}
