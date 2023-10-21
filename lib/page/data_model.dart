// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serumpun_sebalai/page/data.dart';

class DataModel {
  factory DataModel.fromJson(Map<String, dynamic> jsonData) {
    return DataModel(
        idVar: jsonData["var"][0]["val"],
        label: jsonData["var"][0]["label"],
        verVar: jsonData["vervar"] as List,
        jmlVerVar: (jsonData["vervar"] as List).length,
        turVar: jsonData["turvar"] as List,
        jmlTurVar: (jsonData["turvar"] as List).length,
        tahun: jsonData["tahun"] as List,
        jmlTahun: (jsonData["tahun"] as List).length,
        turTahun: jsonData["turtahun"] as List,
        jmlTurTahun: (jsonData["turtahun"] as List).length,
        konten: jsonData["datacontent"] as List,
        jmlKonten: (jsonData["datacontent"] as List).length);
  }
  DataModel({
    required this.idVar,
    required this.label,
    required this.verVar,
    required this.jmlVerVar,
    required this.turVar,
    required this.jmlTurVar,
    required this.tahun,
    required this.jmlTahun,
    required this.turTahun,
    required this.jmlTurTahun,
    required this.konten,
    required this.jmlKonten,
  });

  final int idVar;
  final String label;
  final List verVar;
  final int jmlVerVar;
  final List turVar;
  final int jmlTurVar;
  final List tahun;
  final int jmlTahun;
  final List turTahun;
  final int jmlTurTahun;
  final List konten;
  final int jmlKonten;
}
