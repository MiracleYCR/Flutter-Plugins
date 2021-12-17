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
            ElevatedButton(
              child: Text('我的'),
              onPressed: () {
                PagodaRouter.pagodaNavigator.navigateTo('user', params: {'vid': '我的 id 是 666'});
            }),
            ElevatedButton(
              child: Text('详情'),
              onPressed: () {
                PagodaRouter.pagodaNavigator.navigateTo('detail', params: {'msg': '详情页面'});
            }),
            ElevatedButton(
              child: Text('未知页面'),
              onPressed: () {
                PagodaRouter.pagodaNavigator.navigateTo('error');
            }),
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