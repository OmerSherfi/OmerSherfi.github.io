import 'package:angular/angular.dart';
import 'package:angular_app/Dashboard/dashboard_component.dart';
import 'package:angular_app/Employees/employees_component.dart';
import 'package:angular_app/Login/login_component.dart';
import 'package:angular_app/MainApp/mainapp.component.dart';
import 'package:angular_app/Map/map.component.dart';
import 'package:angular_app/src/Shared/Services.dart';
import 'src/Route/routes.dart';

@Component(selector: 'my-app', template: '''
 <div>
 <div> </div>
 <main-app></main-app>
 </div>
 ''', directives: [
  coreDirectives,
  MainAppComponent,
  DashboardComponent,
  LoginComponenet,
  MapComponent,
  LoginComponenet,
  EmployeesComponent
], exports: [
  RoutePaths,
  Routes
], providers: [
  ClassProvider(Services)
])
class AppComponent {
  Services services = Services();
  bool loggedin = false;
  AppComponent(this.services) {
    var data = services.dataManager.getAliveLocations().then((data) {
      print(data.length);
      print(data[0].currentLocation.lat.toString() +
          "," +
          data[0].currentLocation.long.toString());
    });
  }
//     ngOnInit(){loggedin=_services.handler.isloggedin;}
}
