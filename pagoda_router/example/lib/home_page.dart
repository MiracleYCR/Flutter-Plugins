import 'package:flutter/material.dart';
import 'package:pagoda_router/pagoda_router.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;

  @override
  void initState() {
    super.initState();
    PagodaRouter.pagodaNavigator.addListener(this.listener = (cur, prev) {

    });
  }

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
                PagodaRouter.pagodaNavigator.navigateTo('user', params: {'vid': '6666'});
              })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    PagodaRouter.pagodaNavigator.removeListener(this.listener);
  }
}