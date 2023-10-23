import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FenomenaPage extends StatefulWidget {
  const FenomenaPage({super.key});

  @override
  State<FenomenaPage> createState() => _FenomenaPageState();
}

class _FenomenaPageState extends State<FenomenaPage> {
  final Map<String, String> itemDropDown1 = {
    '1': 'BPS',
    '2': 'Dinas Pertanian',
    '3': 'Dinas Perdagangan'
  };

  bool isDropdown2Visible = false;
  bool isFenomenaVisible = false;

  String? _selectedKeyDropdown1;
  String? _selectedItemDropdown1;
  String? _selectedKeyDropdown2;
  String? _selectedItemDropdown2;

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
