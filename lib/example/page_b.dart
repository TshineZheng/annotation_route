import 'package:annotation_route/example/router.route.dart';
import 'package:annotation_route/route.dart';

@ARoute(url: 'myapp://pageb', params: ['parama', 'b'])
class B {
  String parama;
  int b;
  B(MyRouteOption option) : super(){
    parama = option.params['parama'];
    b = option.params['b'];
  }

  @override
  String toString() {
    return "parama = $parama, b = $b";
  }
}
