import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:table_sticky_headers/table_sticky_headers.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  bool isVisible = false;
  List data = [];
  List judulKolom = [];
  List judulBaris = [];
  String labelJudulBaris = "";
  List<List<String>> kontenData = [];
  var jsonData;
  var jmlVerVar = 0;
  var jmlTurVar = 0;
  var jmlTahun = 0;
  var jmlHorvar = 0;
  var jmlTurTahun = 0;
  String unit = "";
  String judul = "";
  String idData = "1026";
  String kodeAPI = "1";

  clearData() {
    data.clear();
    judulKolom.clear();
    judulBaris.clear();
    kontenData.clear();
  }

  //get data
  Future getData(String id, String kodeAPI) async {
    List _judulKolom = [];
    List _judulBaris = [];
    List<List<String>> _kontenData = [];
    String _unit = "";
    String _judul = "";

    if (kodeAPI == "1") {
      var response = await http.get(Uri.https('webapi.bps.go.id',
          'v1/api/list/model/data/lang/ind/domain/1900/var/$id/key/d560dc954c0b8d1f71c2793d021d3f3d/'));

      var jsonData = jsonDecode(response.body);

      var idVar = jsonData["var"][0]["val"];
      data.add(idVar);

      if (jsonData["var"][0]["unit"] != null) {
        String unitData = jsonData["var"][0]["unit"].toString();
        _unit = "($unitData)";
      }
      unit = _unit;

      _judul = jsonData["var"][0]["label"].toString();
      judul = _judul;

      var turVar = jsonData["turvar"] as List;
      data.add(turVar);

      jmlTurVar = turVar.length;
      data.add(jmlTurVar);

      var labelVerVar = jsonData["labelvervar"];
      labelJudulBaris = labelVerVar;
      data.add(labelVerVar);

      var verVar = jsonData["vervar"] as List;
      data.add(verVar);

      jmlVerVar = verVar.length;
      data.add(jmlVerVar);

      var tahun = jsonData["tahun"] as List;
      data.add(tahun);

      jmlTahun = tahun.length;
      data.add(jmlTahun);

      var turTahun = jsonData["turtahun"] as List;
      data.add(jmlTurTahun);

      jmlTurTahun = turTahun.length;
      data.add(jmlTurTahun);

      for (int i = 0; i < jmlTahun; i++) {
        _judulKolom.add(tahun[i]["label"]);
      }
      for (int i = 0; i < jmlVerVar; i++) {
        _judulBaris.add(verVar[i]["label"]);
      }

      // for (int i = 0; i < jmlTahun; i++) {
      //   final List<String> row = [];
      //   for (int j = 0; j < jmlVerVar; j++) {
      //     row.add('Baris $j, Kolom $i');
      //   }
      //   kontenData.add(row);
      // }

      for (int i = 0; i < jmlTahun; i++) {
        final List<String> row = [];
        for (int j = 0; j < jmlVerVar; j++) {
          for (int k = 0; k < jmlTurVar; k++) {
            for (int l = 0; l < jmlTurTahun; l++) {
              final iddata = jsonData["vervar"][j]["val"].toString() +
                  idVar.toString() +
                  jsonData["turvar"][k]["val"].toString() +
                  jsonData["tahun"][i]["val"].toString() +
                  jsonData["turtahun"][l]["val"].toString();
              final data = (jsonData["datacontent"][iddata] != null)
                  ? jsonData["datacontent"][iddata]
                  : '-';
              row.add(data.toString());
            }
          }
        }
        _kontenData.add(row);
      }
      judulBaris = _judulBaris;
      judulKolom = _judulKolom;
      kontenData = _kontenData;
    } else {
      var response = await http.get(Uri.https(
          'webapps.bps.go.id', 'babel/api_ssebalai/services/tabelData/$id'));

      var jsonData = jsonDecode(response.body);

      var idVar = jsonData["var"][0]["id_tabel"];
      data.add(idVar);

      // if (jsonData["var"][0]["unit"] != null) {
      //   String unitData = jsonData["var"][0]["unit"].toString();
      //   _unit = "($unitData)";
      // }
      _unit = "";
      unit = _unit;

      _judul = jsonData["var"][0]["nama_tabel"].toString();
      judul = _judul;

      // var turVar = jsonData["turvar"] as List;
      // data.add(turVar);

      // jmlTurVar = turVar.length;
      // data.add(jmlTurVar);

      var labelVerVar = jsonData["label_vervar"][0]["label_vervar"];
      // var labelVerVar = "Judul Vertikal Variabel";
      labelJudulBaris = labelVerVar;
      data.add(labelVerVar);

      var verVar = jsonData["ver_var"] as List;
      data.add(verVar);

      jmlVerVar = verVar.length;
      data.add(jmlVerVar);

      var horVar = jsonData["hor_var"] as List;
      data.add(horVar);

      jmlHorvar = horVar.length;
      data.add(jmlHorvar);

      //var turTahun = jsonData["turtahun"] as List;
      // data.add(jmlTurTahun);

      // jmlTurTahun = turTahun.length;
      // data.add(jmlTurTahun);

      for (int i = 0; i < jmlHorvar; i++) {
        _judulKolom.add(horVar[i]["nama_horvar"]);
      }
      for (int i = 0; i < jmlVerVar; i++) {
        _judulBaris.add(verVar[i]["nama_vervar"]);
      }

      // for (int i = 0; i < jmlTahun; i++) {
      //   final List<String> row = [];
      //   for (int j = 0; j < jmlVerVar; j++) {
      //     row.add('Baris $j, Kolom $i');
      //   }
      //   kontenData.add(row);
      // }

      for (int i = 0; i < jmlHorvar; i++) {
        final List<String> row = [];
        for (int j = 0; j < jmlVerVar; j++) {
          final iddata = jsonData["var"][0]["id_tabel"].toString() +
              jsonData["ver_var"][j]["id_vervar"].toString() +
              jsonData["hor_var"][i]["id_horvar"].toString();
          final data = (jsonData["data_content"][iddata] != null)
              ? jsonData["data_content"][iddata]
              : '-';
          row.add(data.toString());
          // for (int k = 0; k < jmlTurVar; k++) {
          //   for (int l = 0; l < jmlTurTahun; l++) {
          //     final iddata = jsonData["vervar"][j]["val"].toString() +
          //         idVar.toString() +
          //         jsonData["turvar"][k]["val"].toString() +
          //         jsonData["tahun"][i]["val"].toString() +
          //         jsonData["turtahun"][l]["val"].toString();
          //     final data = (jsonData["datacontent"][iddata] != null)
          //         ? jsonData["datacontent"][iddata]
          //         : '-';
          //     row.add(data.toString());
          //   }
          // }
        }
        _kontenData.add(row);
      }
      judulBaris = _judulBaris;
      judulKolom = _judulKolom;
      kontenData = _kontenData;
    }
  }

  final Map<String, Map<String, List<String>>> _dropDownMenu = {
    'BPS': {
      '1026': ['1', '1026', 'Inflasi Kota Pangkalpinang'],
      '1054': ['1', '1054', 'Inflasi Kota Tanjungpandan'],
      '1055': ['1', '1055', 'Inflasi Gabungan 2 Kota'],
      '51': ['1', '51', 'Laju Pertumbuhan PDRB Menurut Lapangan Usaha'],
      '1052': ['1', '1052', 'Laju Pertumbuhan PDRB Menurut Pengeluaran'],
    },
    'Dinas Pertanian dan Ketahanan Pangan': {
      '2': [
        '2',
        '2',
        'Prognosa Ketersediaan dan Kebutuhan Konsumsi Beras (Realisasi Januari - Juli 2023)'
      ],
      '3': [
        '2',
        '3',
        'Prognosa Ketersediaan dan Kebutuhan Konsumsi Beras (Potensi Agustus s.d. Oktober 2023)'
      ],
      '4': [
        '2',
        '4',
        'Prognosa Ketersediaan dan Kebutuhan Konsumsi Beras (Prognosa Januari s.d. Desember 2023)'
      ],
      '5': [
        '2',
        '5',
        'Prognosa Ketersediaan dan Kebutuhan Pangan Januari s.d. Desember 2023 (Angka Sementara dan Proyeksi)'
      ]
    },
    'Dinas Perhubungan': {
      '1': [
        '2',
        '1',
        'Subsidi Angkutan Umum untuk Jasa Angkutan Orang dan/atau Barang Antar Kota dalam 1 (satu) Daerah Provinsi Tahun 2023'
      ],
    },
  };

  String? _selectedKey;
  String? _selectedItem;

  final List<String> instansi = [
    'BPS',
    'Dinas Pertanian',
    'Dinas Perdagangan',
    'Dinas Lainnya',
  ];

  String? selectedValueDinas;

  final List<List<String>> indikatorBPS = [
    ['1026', 'Inflasi Kota Pangkalpinang'],
    ['1054', 'Inflasi Kota Tanjungpandan'],
    ['1055', 'Inflasi Gabungan 2 Kota'],
  ];

  Widget table() {
    // if(jumlahTahun == 1 && jumlahKarakteristik == 1){
    //   return
    // }
    return StickyHeadersTable(
      columnsLength: judulKolom.length,
      rowsLength: judulBaris.length,
      columnsTitleBuilder: (i) => TableCell.stickyRow(
        judulKolom[i],
        textStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      rowsTitleBuilder: (i) => TableCell.stickyColumn(
        judulBaris[i],
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentCellBuilder: (i, j) => TableCell.content(
        kontenData[i][j],
      ),
      legendCell: TableCell.legend(
        labelJudulBaris,
        textStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Widget table() {
  //   // if(jumlahTahun == 1 && jumlahKarakteristik == 1){
  //   //   return
  //   // }
  //   return StickyHeadersTable(
  //     columnsLength: judulKolom.length,
  //     rowsLength: judulBaris.length,
  //     columnsTitleBuilder: (i) => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Text(
  //         judulKolom[i],
  //         style:
  //             const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  //       ),
  //     ),
  //     rowsTitleBuilder: (i) => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Text(
  //         judulBaris[i],
  //         style: const TextStyle(
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     contentCellBuilder: (i, j) => Text(
  //       kontenData[i][j],
  //     ),
  //     legendCell: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Text(
  //         labelJudulBaris,
  //         style:
  //             const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  // Widget table() {
  //   return
  // }

  String? selectedValueIndikator;

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
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
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              //   child: Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         color: Colors.grey[100],
              //         borderRadius: BorderRadius.circular(10)),
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Cari',
              //           style: TextStyle(color: Colors.grey),
              //         ),
              //         Icon(
              //           Icons.search,
              //           color: Colors.grey,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                    // items: instansi
                    //     .map(
                    //       (String item) => DropdownMenuItem<String>(
                    //         value: item,
                    //         child: Text(
                    //           item,
                    //           style: const TextStyle(
                    //             color: Color.fromARGB(255, 58, 58, 58),
                    //             fontSize: 13,
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //     .toList(),
                    // value: selectedValueDinas,
                    // onChanged: (value) {
                    //   setState(() {
                    //     selectedValueDinas = value;
                    //   });
                    // },
                    value: _selectedKey,
                    onChanged: (value) {
                      setState(() {
                        _selectedKey = value;
                        _selectedItem = null;
                        isVisible = false;
                      });
                    },
                    items: _dropDownMenu.keys
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
              _selectedKey != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Pilih Indikator',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // items: indikator
                          //     .map(
                          //       (String item) => DropdownMenuItem<String>(
                          //         value: item,
                          //         child: Text(
                          //           item,
                          //           style: const TextStyle(
                          //             color: Color.fromARGB(255, 58, 58, 58),
                          //             fontSize: 13,
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //     .toList(),
                          // value: selectedValueIndikator,
                          // onChanged: (value) {
                          //   setState(() {
                          //     selectedValueIndikator = value;
                          //   });
                          //   visibility = true;
                          // },
                          value: _selectedItem,
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value;
                              isVisible = true;

                              var _idData =
                                  _dropDownMenu[_selectedKey]!.keys.firstWhere(
                                        (k) => _dropDownMenu[_selectedKey]![k]!
                                            .contains(value),
                                        orElse: () => "1",
                                      );

                              var _kodeAPI =
                                  _dropDownMenu[_selectedKey]![_idData]![0];
                              clearData();

                              idData = _idData;
                              kodeAPI = _kodeAPI;
                              getData(idData, kodeAPI);
                            });
                          },
                          items: _dropDownMenu[_selectedKey]!
                              .values
                              .map<DropdownMenuItem<String>>(
                                  (List<String> value) {
                            return DropdownMenuItem<String>(
                              value: value[1],
                              child: Text(
                                value[2],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                    )
                  : Container(),
              Expanded(
                child: Visibility(
                  visible: isVisible,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: FutureBuilder(
                      future: getData(idData, kodeAPI),
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$judul $unit',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  // child: ListView.builder(
                                  //   itemCount: judulKolom.length,
                                  //   itemBuilder: (context, index) {
                                  //     return ListTile(
                                  //       title: Text(judulKolom[index].toString()),
                                  //     );
                                  //   },
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: StickyHeadersTable(
                                      columnsLength: judulKolom.length,
                                      rowsLength: judulBaris.length,
                                      columnsTitleBuilder: (i) => Container(
                                        width: scrWidth / 3,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left:
                                                BorderSide(color: Colors.white),
                                            right:
                                                BorderSide(color: Colors.white),
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            top:
                                                BorderSide(color: Colors.white),
                                          ),
                                          color: Color(0xFF659dd4),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                              child: Text(
                                                judulKolom[i],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      rowsTitleBuilder: (i) => Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 5,
                                        ),
                                        width: scrWidth / 3,
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                color: Colors.black26),
                                            right: BorderSide(
                                                color: Colors.black26),
                                            bottom: BorderSide(
                                                color: Colors.black26),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              judulBaris[i],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentCellBuilder: (i, j) => Container(
                                        width: scrWidth / 3,
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: Colors.black26),
                                            bottom: BorderSide(
                                                color: Colors.black26),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                              child: Text(
                                                kontenData[i][j],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      legendCell: Container(
                                        width: scrWidth / 3,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left:
                                                BorderSide(color: Colors.white),
                                            right:
                                                BorderSide(color: Colors.white),
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            top:
                                                BorderSide(color: Colors.white),
                                          ),
                                          color: Color(0xFF659dd4),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                labelJudulBaris,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      cellDimensions: CellDimensions.fixed(
                                        contentCellWidth: scrWidth / 3,
                                        contentCellHeight: 70,
                                        stickyLegendWidth: scrWidth / 3,
                                        stickyLegendHeight: 80,
                                      ),
                                      cellAlignments:
                                          const CellAlignments.fixed(
                                        contentCellAlignment: Alignment.center,
                                        stickyColumnAlignment:
                                            Alignment.centerLeft,
                                        stickyRowAlignment: Alignment.center,
                                        stickyLegendAlignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                  // child: table(),
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
              // Expanded(
              //   child: Visibility(
              //     visible: visibility,
              //     child: Container(
              //       decoration: const BoxDecoration(
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(12),
              //           topRight: Radius.circular(12),
              //         ),
              //         color: Colors.white,
              //       ),
              //       child: SingleChildScrollView(
              //         child: Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Column(
              //             children: [
              //               const Padding(
              //                 padding: EdgeInsets.all(8.0),
              //                 child: Text(
              //                   'Inflasi Bulanan Kota Pangkalpinang, 2021-2023',
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 15,
              //                   ),
              //                 ),
              //               ),
              //               DataTable(
              //                 columns: const <DataColumn>[
              //                   DataColumn(
              //                     label: Expanded(
              //                       child: Text(
              //                         'Bulan',
              //                         style: TextStyle(
              //                             fontStyle: FontStyle.italic),
              //                       ),
              //                     ),
              //                   ),
              //                   DataColumn(
              //                     label: Expanded(
              //                       child: Text(
              //                         '2021',
              //                         style: TextStyle(
              //                             fontStyle: FontStyle.italic),
              //                       ),
              //                     ),
              //                   ),
              //                   DataColumn(
              //                     label: Expanded(
              //                       child: Text(
              //                         '2022',
              //                         style: TextStyle(
              //                             fontStyle: FontStyle.italic),
              //                       ),
              //                     ),
              //                   ),
              //                   DataColumn(
              //                     label: Expanded(
              //                       child: Text(
              //                         '2023',
              //                         style: TextStyle(
              //                             fontStyle: FontStyle.italic),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //                 rows: const <DataRow>[
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Januari')),
              //                       DataCell(Text('1.17')),
              //                       DataCell(Text('1.22')),
              //                       DataCell(Text('-0.10')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Februari')),
              //                       DataCell(Text('-0.33')),
              //                       DataCell(Text('-0.53')),
              //                       DataCell(Text('-0.31')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Maret')),
              //                       DataCell(Text('-0.12')),
              //                       DataCell(Text('1.10')),
              //                       DataCell(Text('0.26')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('April')),
              //                       DataCell(Text('0.30')),
              //                       DataCell(Text('1.82')),
              //                       DataCell(Text('0.58')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Mei')),
              //                       DataCell(Text('0.23')),
              //                       DataCell(Text('0.85')),
              //                       DataCell(Text('0.01')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Juni')),
              //                       DataCell(Text('0.23')),
              //                       DataCell(Text('-0.22')),
              //                       DataCell(Text('0.40')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Juli')),
              //                       DataCell(Text('-0.32')),
              //                       DataCell(Text('1.01')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Agustus')),
              //                       DataCell(Text('-0.27')),
              //                       DataCell(Text('-1.20')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('September')),
              //                       DataCell(Text('0.60')),
              //                       DataCell(Text('1.04')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Oktober')),
              //                       DataCell(Text('0.03')),
              //                       DataCell(Text('-0.30')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('November')),
              //                       DataCell(Text('0.77')),
              //                       DataCell(Text('0.19')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                   DataRow(
              //                     cells: <DataCell>[
              //                       DataCell(Text('Desember')),
              //                       DataCell(Text('1.27')),
              //                       DataCell(Text('0.99')),
              //                       DataCell(Text('-')),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Visibility(
              //   visible: visibility,
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Card(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       color: const Color(0xFF5289c7),
              //       child: const Padding(
              //         padding: EdgeInsets.all(20.0),
              //         child: Column(
              //           children: [],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  TableCell.content(
    this.text, {
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 400,
        contentCellHeight: 500,
        stickyLegendWidth: 400,
        stickyLegendHeight: 500),
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = const Color(0xFF6097d0),
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
    this.text, {
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 400,
        contentCellHeight: 500,
        stickyLegendWidth: 400,
        stickyLegendHeight: 500),
    this.colorBg = const Color(0xFF6097d0),
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = const Color(0xFF6097d0),
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 10.0);

  TableCell.stickyRow(
    this.text, {
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 400,
        contentCellHeight: 500,
        stickyLegendWidth: 400,
        stickyLegendHeight: 500),
    this.colorBg = const Color(0xFF6097d0),
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = const Color(0xFF6097d0),
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
    this.text, {
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 400,
        contentCellHeight: 500,
        stickyLegendWidth: 400,
        stickyLegendHeight: 500),
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = const Color(0xFF6097d0),
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 10.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _colorHorizontalBorder),
              right: BorderSide(color: _colorHorizontalBorder),
            ),
            color: colorBg),
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 5,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
      ),
    );
  }
}
