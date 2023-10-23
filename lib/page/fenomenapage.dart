import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FenomenaPage extends StatefulWidget {
  const FenomenaPage({super.key});

  @override
  State<FenomenaPage> createState() => _FenomenaPageState();
}

class _FenomenaPageState extends State<FenomenaPage> {
  final Map<String, String> itemDropDown1 = {
    '1': 'BPS',
    '2': 'Dinas Pertanian dan Ketahanan Pangan',
    '3': 'Dinas Perindustrian dan Perdagangan',
    '4': 'Dinas Perhubungan',
    '5': 'Dinas PUPRPRKP',
    '6': 'KSOP Pangkal Balam'
  };

  final Map<String, String> bulan = {
    '1': 'Januari',
    '2': 'Februari',
    '3': 'Maret',
    '4': 'April',
    '5': 'Mei',
    '6': 'Juni',
    '7': 'Juli',
    '8': 'Agustus',
    '9': 'September',
    '10': 'Oktober',
    '11': 'November',
    '12': 'Desember',
  };

  bool isDropdown2Visible = false;
  bool isFenomenaVisible = false;

  String? _selectedKeyDropdown1;
  String? _selectedItemDropdown1;
  String? _selectedKeyDropdown2;
  String? _selectedItemDropdown2;

  List<List<String>> kontenData = [];
  String idData = "";

  Future getData(String id) async {
    List<List<String>> _kontenData = [];
    var response = await http.get(Uri.https(
        'webapps.bps.go.id', 'babel/api_ssebalai/services/fenomena/$id'));

    var jsonData = jsonDecode(response.body);
    var jsonList = jsonData as List;
    var length = jsonList.length;
    String? bulanText = "";
    for (int i = 0; i < length; i++) {
      final List<String> row = [];
      bulanText = bulan[jsonData[i]["bulan"].toString()];
      row.add(jsonData[i]["judul_fenomena"].toString());
      row.add(jsonData[i]["fenomena"].toString());
      row.add(bulanText!);
      // row.add(jsonData[i]["bulan"].toString());
      row.add(jsonData[i]["tahun"].toString());
      _kontenData.add(row);
    }
    kontenData = _kontenData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8aa4d5), Color(0xFF6097d0)],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Drawer(
            child: Container(
              color: const Color(0xFF87a5d6),
              child: ListView(
                children: const [
                  DrawerHeader(
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text('Beranda'),
        //   backgroundColor: const Color(0xFF5b8fcb),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pilih Instansi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    value: _selectedKeyDropdown1,
                    onChanged: (value) {
                      setState(() {
                        _selectedKeyDropdown1 = value;
                        _selectedItemDropdown1 = value;
                        isFenomenaVisible = true;
                        var _idData = itemDropDown1.keys.firstWhere(
                          (k) => itemDropDown1[k] == value,
                          orElse: () => "1",
                        );
                        idData = _idData;
                        getData(idData);
                      });
                    },
                    items: itemDropDown1.values
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
                    buttonStyleData: ButtonStyleData(
                      height: 45,
                      padding: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      elevation: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      //offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: isFenomenaVisible,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: FutureBuilder(
                      future: getData(idData),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: kontenData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Card(
                                          elevation: 5,
                                          child: ExpansionTile(
                                            title: Text(
                                              kontenData[index][0].toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              'Periode: ${kontenData[index][2].toString()} ${kontenData[index][3].toString()}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(kontenData[index][1]
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
