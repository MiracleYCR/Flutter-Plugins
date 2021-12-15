part of pagoda_router;

typedef Future<bool> RouteInterceptor(BuildContext context);
typedef WidgetBuilder RouteBuilder({Map? args});

class PagodaRouteInfo {
  final String path;
  final String name;
  final WidgetBuilder? builder;

  final RouteBuilder? builder2;

  final List<RouteInterceptor>? interceptors;

  PagodaRouteInfo({required this.path, required this.name, this.builder, this.builder2, this.interceptors});
}