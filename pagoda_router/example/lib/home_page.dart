import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<String> onJumpToUser;

  HomePage({Key? key, required this.onJumpToUser}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('首页'),
            MaterialButton(
              child: Text('我的'),
              onPressed: () {
                print('hhhhhh');
                widget.onJumpToUser('123');
              })
          ],
        ),
      ),
    );
  }
}