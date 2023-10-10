import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  bool visibility = false;

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

  String? selectedValueIndikator;

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
                child: Visibility(
                  visible: visibility,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Inflasi Bulanan Kota Pangkalpinang, 2021-2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Bulan',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      '2021',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      '2022',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      '2023',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: const <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Januari')),
                                    DataCell(Text('1.17')),
                                    DataCell(Text('1.22')),
                                    DataCell(Text('-0.10')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Februari')),
                                    DataCell(Text('-0.33')),
                                    DataCell(Text('-0.53')),
                                    DataCell(Text('-0.31')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Maret')),
                                    DataCell(Text('-0.12')),
                                    DataCell(Text('1.10')),
                                    DataCell(Text('0.26')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('April')),
                                    DataCell(Text('0.30')),
                                    DataCell(Text('1.82')),
                                    DataCell(Text('0.58')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Mei')),
                                    DataCell(Text('0.23')),
                                    DataCell(Text('0.85')),
                                    DataCell(Text('0.01')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Juni')),
                                    DataCell(Text('0.23')),
                                    DataCell(Text('-0.22')),
                                    DataCell(Text('0.40')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Juli')),
                                    DataCell(Text('-0.32')),
                                    DataCell(Text('1.01')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Agustus')),
                                    DataCell(Text('-0.27')),
                                    DataCell(Text('-1.20')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('September')),
                                    DataCell(Text('0.60')),
                                    DataCell(Text('1.04')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Oktober')),
                                    DataCell(Text('0.03')),
                                    DataCell(Text('-0.30')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('November')),
                                    DataCell(Text('0.77')),
                                    DataCell(Text('0.19')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Desember')),
                                    DataCell(Text('1.27')),
                                    DataCell(Text('0.99')),
                                    DataCell(Text('-')),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
