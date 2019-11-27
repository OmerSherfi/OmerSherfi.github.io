import 'package:angular/angular.dart';
import 'package:angular_app/Dashboard/dashboard_component.dart';
import 'package:angular_app/Employees/employees_component.dart';
import 'package:angular_app/Map/map.component.dart';
import 'package:angular_app/src/Route/routes.dart';
import 'package:angular_router/angular_router.dart';

@Component(
    selector: 'main-app',
    templateUrl: "indec.html",
    directives: [
      routerDirectives,
      DashboardComponent,
       MapComponent,
       EmployeesComponent],
    exports: 
  [
    RoutePaths,Routes
    ])
class MainAppComponent {}
