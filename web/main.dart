
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_app/app_component.template.dart' as ng;
import 'package:angular_app/MainApp/mainapp.component.template.dart' as mg;

import 'main.template.dart' as self;

const useHashLS = false;
@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;
void main() {
  // initLocator();
  // locator<Repository>()
  //     .addItem(Property(description: 'from omer pc'))
  //     .then((data) {
  //   print(jsonEncode(data.toJson()));
  // });
  
  runApp(ng.AppComponentNgFactory,createInjector: injector);
}
