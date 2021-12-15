import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String? msg;

  const DetailPage({ Key? key, this.msg }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('hhhhh ----- ${widget.msg}'),
      ),
    );
  }
}