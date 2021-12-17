part of pagoda_router;

typedef WidgetBuilder RouteBuilder({Map? params});

// 路由信息
class PagodaRoute {
  final String path;
  final String name;
  final RouteBuilder? builder;
  PagodaRoute({required this.path, required this.name, this.builder});
}

class PagodaRouteParserInfo {
  final String path;
  final String name;
  final Map? params;
  final Object? state;

  PagodaRouteParserInfo({required this.path, required this.name, this.params, this.state});
}
