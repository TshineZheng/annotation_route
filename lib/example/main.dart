import 'router.route.dart';

void main() {
  final router = Router();
  final pageb = router.getPage(MyRouteOption(urlpattern: 'myapp://pageb', params: {'parama': '1', 'b': 2}));
  print(pageb.widget);
}
