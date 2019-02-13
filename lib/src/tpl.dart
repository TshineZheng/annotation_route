const String clazzTpl = """
import 'package:annotation_route/route.dart';
{{#refs}}
import '{{{path}}}';
{{/refs}}

class ARouterInternalImpl extends ARouterInternal {
  ARouterInternalImpl();
  final Map<String, List<Map<String, dynamic>>> innerRouterMap = <String, List<Map<String, dynamic>>>{{{routerMap}}};

  @override
  bool hasPageConfig(ARouteOption option) {
    final dynamic pageConfig = findPageConfig(option);
    return pageConfig != null;
  }

  @override
  ARouterResult findPage(ARouteOption option, dynamic initOption) {
    final dynamic pageConfig = findPageConfig(option);
    if(pageConfig != null) {
      return implFromPageConfig(pageConfig, initOption);
    } else {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
  }

  void instanceCreated(dynamic clazzInstance, Map<String, dynamic> pageConfig) {
    {{{instanceCreated}}}
  }

  dynamic instanceFromClazz(Type clazz, dynamic option) {
    {{{instanceFromClazz}}}
  }

  ARouterResult implFromPageConfig(Map<String, dynamic> pageConfig, dynamic option) {
    final String interceptor = pageConfig['interceptor'];
    if(interceptor != null) {
      return ARouterResult(state: ARouterResultState.REDIRECT, interceptor: interceptor);
    }
    final Type clazz = pageConfig['clazz'];
    if (clazz == null) {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
    try {
      final dynamic clazzInstance = instanceFromClazz(clazz, option);
      instanceCreated(clazzInstance, pageConfig);
      return ARouterResult(widget: clazzInstance, state: ARouterResultState.FOUND);
    } catch (e) {
      return ARouterResult(state: ARouterResultState.NOT_FOUND);
    }
  }

  dynamic findPageConfig(ARouteOption option) {
    final List<Map<String, dynamic>> pageConfigList = innerRouterMap[option.urlpattern];
        if (null != pageConfigList) {
          for (int i = 0; i < pageConfigList.length; i++) {
            final Map<String, dynamic> pageConfig = pageConfigList[i];
            final String paramsString = pageConfig['params'];
            if (null != paramsString) {
              List<String> params = paramsString.split(',');
              if (null != params) {
                bool match = true;
                final Function matchParams = (String k) {
                  if(!option.params.containsKey(k)){
                    match = false;
                    print('router {\${option.urlpattern}} key not match:\$k');
                  }
                };
                params.forEach(matchParams);
                if (match) {
                  return pageConfig;
                }
              } else {
                print('ERROR: in parsing paramsA{pageConfig}');
              }
            } else {
              return pageConfig;
            }
          }
        }
        return null;
  }
}
""";

const String instanceCreatedTpl = """
""";
