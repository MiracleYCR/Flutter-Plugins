part of pagoda_router;

class PagodaPage extends Page {
  final LocalKey key;
  final String name;
  final WidgetBuilder builder;

  const PagodaPage({
    required this.key,
    required this.name,
    required this.builder
  }) : super(
    key: key,
    name: name,
  );

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: builder
    );
  }
}