part of pagoda_router;

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('未知路由'),
      ),
      body: Center(child: Text('404')),
    );
  }
}