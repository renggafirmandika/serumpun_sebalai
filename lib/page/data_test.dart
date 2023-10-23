import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataTest extends StatelessWidget {
  DataTest({super.key});

  List data = [];
  var jsonData;

  //get data
  Future getData() async {
    data.clear();
    var response = await http.get(Uri.https('webapi.bps.go.id',
        'v1/api/list/model/data/lang/ind/domain/1900/var/565/key/d560dc954c0b8d1f71c2793d021d3f3d/'));
    jsonData = jsonDecode(response.body);
    var idVar = jsonData["var"][0]["val"];
    data.add(idVar);
    var verVar = jsonData["vervar"] as List;
    var jmlVerVar = verVar.length;
    data.add(jmlVerVar);
    var turVar = jsonData["turvar"] as List;
    var jmlTurVar = turVar.length;
    data.add(jmlTurVar);
    var tahun = jsonData["tahun"] as List;
    var jmlTahun = tahun.length;
    data.add(jmlTahun);
    var turTahun = jsonData["turtahun"] as List;
    var jmlTurTahun = turTahun.length;
    data.add(jmlTurTahun);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(jsonData["var"][0]["label"].toString()),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].toString()),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
