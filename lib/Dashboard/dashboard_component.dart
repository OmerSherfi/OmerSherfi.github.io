import 'package:angular/angular.dart';
import 'package:angular_app/src/dashboard-controls.dart';

@Component(selector: 'dash-app', templateUrl: 'dashboard_component.html')
class DashboardComponent {
  DashboardContols ctr = DashboardContols();

  DashboardComponent() {
    ctr.createBarChart();
  }
}
