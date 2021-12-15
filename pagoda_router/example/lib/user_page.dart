import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final String? vid;

  UserPage({Key? key, this.vid}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('我的 id：${widget.vid}'),
          ],
        ),
      ),
    );
  }
}