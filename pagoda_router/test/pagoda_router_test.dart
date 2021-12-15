import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pagoda_router/pagoda_router.dart';

void main() {
  const MethodChannel channel = MethodChannel('pagoda_router');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PagodaRouter.platformVersion, '42');
  });
}
