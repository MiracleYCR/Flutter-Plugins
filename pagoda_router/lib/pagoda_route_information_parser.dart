part of pagoda_router;

class PagodaRouteInformationParser extends RouteInformationParser<PagodaRouteParserInfo> {

  // 解析路由
  @override
  Future<PagodaRouteParserInfo> parseRouteInformation(RouteInformation routeInformation) async {
    print('parseRouteInformation ----> location: ${routeInformation.location} state: ${routeInformation.state}');

    String _location = routeInformation.location ?? '/';
    Object? _state = routeInformation.state;

    final uri = Uri.parse(_location);

    print(uri.pathSegments);

    if (uri.pathSegments.isEmpty) {
      return PagodaRouteParserInfo(path: _location, name: 'home', params: null, state: _state);
    }

    return PagodaRouteParserInfo(path: _location, name: uri.pathSegments[0], params: null, state: _state);
  }
}