import 'dart:convert';
import 'dart:js_interop';
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
  bool visibility = false;
  List data = [];
  List judulKolom = [];
  List judulBaris = [];
  String labelJudulBaris = "";
  List<List<String>> kontenData = [];
  var jsonData;
  var jmlVerVar;
  var jmlTurVar;
  var jmlTahun;
  var jmlTurTahun;

  //get data
  Future getData() async {
    data.clear();
    var response = await http.get(Uri.https('webapi.bps.go.id',
        'v1/api/list/model/data/lang/ind/domain/1900/var/1026/key/d560dc954c0b8d1f71c2793d021d3f3d/'));
    jsonData = jsonDecode(response.body);

    var idVar = jsonData["var"][0]["val"];
    data.add(idVar);

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
      judulKolom.add(tahun[i]["label"]);
    }
    for (int i = 0; i < jmlVerVar; i++) {
      judulBaris.add(verVar[i]["label"]);
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
            final data = jsonData["datacontent"][iddata] != ""
                ? jsonData["datacontent"][iddata]
                : '-';
            row.add(data.toString());
          }
        }
      }
      kontenData.add(row);
    }
  }

  final List<String> instansi = [
    'BPS',
    'Dinas Pertanian',
    'Dinas Perdagangan',
    'Dinas Lainnya',
  ];

  String? selectedValueDinas;

  final List<String> indikator = [
    'Inflasi ',
    'Pertumbuhan Ekonomi',
    'Kemiskinan',
    'Ketenagakerjaan',
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
                    items: instansi
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 58, 58, 58),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedValueDinas,
                    onChanged: (value) {
                      setState(() {
                        selectedValueDinas = value;
                      });
                    },
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
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
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
                    items: indikator
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 58, 58, 58),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedValueIndikator,
                    onChanged: (value) {
                      setState(() {
                        selectedValueIndikator = value;
                      });
                      visibility = true;
                    },
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
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: FutureBuilder(
                    future: getData(),
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
                                child: Center(
                                  child: Text(
                                      jsonData["var"][0]["label"].toString()),
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
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white),
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                        ),
                                        color: Color(0xFF659dd4),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            judulKolom[i],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    rowsTitleBuilder: (i) => Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: scrWidth / 3,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left:
                                              BorderSide(color: Colors.black26),
                                          right:
                                              BorderSide(color: Colors.black26),
                                          bottom:
                                              BorderSide(color: Colors.black26),
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    contentCellBuilder: (i, j) => Container(
                                      width: scrWidth / 3,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right:
                                              BorderSide(color: Colors.black26),
                                          bottom:
                                              BorderSide(color: Colors.black26),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(kontenData[i][j]),
                                        ],
                                      ),
                                    ),
                                    legendCell: Container(
                                      width: scrWidth / 3,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white),
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
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
                                            padding: const EdgeInsets.all(3.0),
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
                                    cellAlignments: const CellAlignments.fixed(
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
