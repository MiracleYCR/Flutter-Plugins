part of pagoda_router;

class PagodaRouteInformationParser extends RouteInformationParser<PagodaRouteInfo> {

  final List<PagodaRouteInfo> registerRoutes;

  PagodaRouteInformationParser({required this.registerRoutes});


  @override
  Future<PagodaRouteInfo> parseRouteInformation(RouteInformation routeInformation) async {
    String path = routeInformation.location ?? '/';
    Object? body = routeInformation.state;

    // 该路由是否已注册
    bool hasRegister = registerRoutes.where((route) => route.path == path).toList().isNotEmpty;
    

    // 没有注册返回 404 路由
    if (!hasRegister) {
      return PagodaRouteInfo(path: '/404', name: '404');
    }

    
    print('PagodaRouteInformationParser ------> ${routeInformation.location}');
    return PagodaRouteInfo(path: '/', name: 'root');
  }
}