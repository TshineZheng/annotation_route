import 'package:annotation_route/example/router.route.dart';
import 'package:annotation_route/route.dart';

@ARoute(url: 'myapp://pagea')
class A {
  int a;
  String b;
  A(MyRouteOption option) : super();
}
