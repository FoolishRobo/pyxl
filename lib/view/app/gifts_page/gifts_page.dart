import 'package:flutter/material.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({Key? key}) : super(key: key);

  @override
  State<GiftsPage> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Gifts Page")),
    );
  }
}
