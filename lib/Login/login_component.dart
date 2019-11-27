

import 'package:angular/angular.dart';
import 'package:angular_app/src/Shared/Services.dart';

@Component(

selector: "login-app",
templateUrl: "login_component.html",
  directives: [coreDirectives],
  providers: [ClassProvider(Services)]
)

class LoginComponenet
{
  Services service;
  LoginComponenet(this.service);

 void onLoginClicked()
  {
    print("pressed");
      service.handler.isloggedin=true;
      print(service.handler.isloggedin);
      
  }
}