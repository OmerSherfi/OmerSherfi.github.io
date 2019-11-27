import 'package:angular_router/angular_router.dart';
import 'route_paths.dart';
import 'package:angular_app/MainApp/mainapp.component.template.dart' as mainapptemplate;
import 'package:angular_app/Dashboard/dashboard_component.template.dart' as dashboardtemplate;
import 'package:angular_app/Login/login_component.template.dart' as logintemplate;
import 'package:angular_app/Employees/employees_component.template.dart' as employeestemplate;
import 'package:angular_app/Map/map.component.template.dart' as maptemplate;
import 'package:angular_app/Map/map.component2.template.dart' as maptemplate2;
export 'route_paths.dart';

class Routes {
  static final dashboard = RouteDefinition(routePath: RoutePaths.dashboard,component: dashboardtemplate.DashboardComponentNgFactory);
  static final login=RouteDefinition(routePath: RoutePaths.login,component: logintemplate.LoginComponenetNgFactory);
  static final employees =RouteDefinition(routePath: RoutePaths.employees,component: employeestemplate.EmployeesComponentNgFactory);
  static final map =RouteDefinition(routePath: RoutePaths.map,component: maptemplate.MapComponentNgFactory);
  static final map2 =RouteDefinition(routePath: RoutePaths.map2,component: maptemplate2.MapComponent2NgFactory);
  static final all = <RouteDefinition>[
    dashboard,login,employees,map,map2
  ];
}