import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class DataManager {
  // Object getByID(String id) {
  //   return null;
  // }

// user operations

// Request/Respond Operations
  Timer _timer;

  // void _timerHandler(Timer timer) {
  //   getAliveLocations().then((data) {
  //     data;
  //     for (int i = 0; i < data.length; i++) {
  //       //  if(data[i])
  //     }
  //   });
  // }

  void startTimer(Function handler) {
    _timer = Timer.periodic(Duration(seconds: 10), handler);
  }

  void stopTimer() {
    _timer.cancel();
    _timer = null;
  }

  Future<List<Operation>> getAllOperations(
      {bool unfinishedOnly = false}) async {
    var response = await Data().getAllObjects("CollectionRequest",
        where: {if (unfinishedOnly) "isCompleted": false});
    if (response != null) {
      List decode = jsonDecode(response)["results"];
      return decode
          .map(
            (i) => Operation()
              ..id = i['objectId']
              ..customerId = i['customerId']
              ..date =
                  DateTime.tryParse(i['createdAt']) // shouldn't be createdAt!
              ..employeeID = i['toktokId']
              ..propertyid = i['propertyId'],
          )
          .toList();

      //showMessageBox(title: formatJsonString(decode));
    } else {
      return null;
    }
  }

  Future<List<Trackers>> getAliveLocations() async {
    var response = await Data().getAllObjects("Device");
    if (response != null) {
      List decode = jsonDecode(response)["results"];
      return decode
          .map(
            (i) => Trackers()
              ..trackId = i['objectId']
              ..userId = i['userId']
              ..currentLocation = (GeoLocation()
                ..lat = double.tryParse(i['latitude'] ?? "")
                ..long = double.tryParse(i['longitude'] ?? "")),
          )
          .toList();

      //showMessageBox(title: formatJsonString(decode));
    } else {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    var response = await Data().getAllObjects("_User");
    if (response != null) {
      List decode = jsonDecode(response)["results"];
      return decode
          .map(
            (i) => User()
              ..id = i['objectId']
              ..name = i['username']
              ..type = i['type'] //toktokDriver or customer
            ,
          )
          .toList();

      //showMessageBox(title: formatJsonString(decode));
    } else {
      return null;
    }
  }

  Future<List<Property>> getAllProperties() async {
    var response = await Data().getAllObjects("Property");
    if (response != null) {
      List decode = jsonDecode(response)["results"];
      return decode
          .map(
            (i) => Property()
              ..id = i['objectId']
              // ..city = i['city'] //... no data yet , skipping :D\
              ..description = i['description']
              ..currentLocation = (GeoLocation()
                ..lat = double.tryParse(i['latitude'] ?? "")
                ..long = double.tryParse(i['longitude'] ?? "")),
          )
          .toList();

      //showMessageBox(title: formatJsonString(decode));
    } else {
      return null;
    }
  }

// log in Operations

}

class Operation {
  // requests/responds

  String id;
  String customerId;
  String propertyid;
  String employeeID;
  DateTime date;
  // and other evaluating data might be usfull
}

class Trackers {
  String trackId;
  String userId;
  GeoLocation currentLocation;
}

class User {
  String id;
  Object identification;
  String name;
  int phoneNo;
  //toktokDriver or customer
  String type;
  bool get isToktokDriver => type == "toktokDriver";
  bool get isCustomer => type == "customer";
}

class Property {
  String id;
  GeoLocation currentLocation;
  String description;
  String city;
  String municipality;
  String neighborhood;
  String block;
  String number;
  String remarks;
}

class GeoLocation {
  double long;
  double lat;
}
// class User {
//   int id;
//   Object identification;
//   Object image;
//   String name;
//   String city;
//   String municipality;
//   String neighborhood;
//   String block;
//   String houseNo;
//   int phoneNo;
// }

// class Employee {
//   int id;
//   Trackers deviceInfo;
//   Object identification;
//   Object image;
//   String name;
//   String city;
//   String municipality;
//   String neighborhood;
//   String block;
//   String houseNo;
//   int phoneNo;
//   String userName;
//   String password;
// }

// class Customer {
//   int id;
//   Object identification;
//   String name;
//   String city;
//   String municipality;
//   String neighborhood;
//   String block;
//   String houseNo;
//   int phoneNo;
// }

// class Operation {
//   // requests/responds

//   int id;
//   Customer whoRequests;
//   String employeeID;
//   DateTime date;
//   // and other evaluating data might be usfull
// }

// class Trackers {
//   int trackId;
//   GeoLocation currentLocation;
// }

// class GeoLocation {
//   double long;
//   double lat;
// }

// class DischargeRequest {
//   int id;
//   User whoRequests;
//   DateTime date;
// }

class LaterOn {
  List<User> getAllUsers() {
    return null;
  }

  String saveUser(User object) {
    return null;
  }

  bool updateUser(User object) {
    return true;
  }

  bool deleteUser(User object) {
    return true;
  }

//customer operations
//   List<Customer> getAllCustomers() {
//     return null;
//   }

//   String saveCustomer(Customer object) {
//     return null;
//   }

//   bool updateCustomer(Customer object) {
//     return true;
//   }

//   bool deleteCustomer(Customer object) {
//     return true;
//   }

// //empoyees operations
//   List<Employee> getAllEmployees() {
//     return null;
//   }

//   String saveEmployee(Employee object) {
//     return null;
//   }

//   bool updateEmployee(Employee object) {
//     return true;
//   }

//   bool deleteEmployee(Employee object) {
//     return true;
//   }

  bool logIn(String username, String password) {}

  List<String> getRequestLocations() {
    return null;
  }
}

class Data {
  static const _keyApplicationId = "yVfnUOPeyexgg9MXksDwxipuGks88kUrqlJZVHiR";
  static const _keyParseServerUrl = "https://parseapi.back4app.com";
  //static String _keyParseServerUrl = "http://ahmedgubara.ddns.net/parse";
  static const _masterKey = "6PoldEjziKBhrdiqsX1z0y3XMfUFQIKq3tkHGBy3";
  static const _restclientKey = "3trvz4G9ni3qDeAIfDfmfX4hVUITIhhiQlgY8wJf";
  Future<String> getAllObjects(String classname, {Map where}) async {
    String wherestr = "";
    if (where != null) {
      wherestr = "?where=" + Uri.encodeFull(jsonEncode(where));
    }
    var url = "$_keyParseServerUrl/classes/$classname$wherestr";
    print(url);
    var response = await http.get(url, headers: {
      "X-Parse-Application-Id": "$_keyApplicationId",
      "X-Parse-REST-API-Key": "$_restclientKey",
      "X-Parse-Master-Key": "$_masterKey"
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return null;
    }
  }
}
