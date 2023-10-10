import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool visibility = false;

  void showWidget() {
    setState(() {
      visibility = true;
    });
  }

  void hideWidget() {
    setState(() {
      visibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: const Color(0xFF5289c7),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
