import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_app/src/Service/dataManager.dart';
import 'package:angular_app/src/Shared/Services.dart';
import 'package:angular_app/src/draw_trackers.dart';
import 'dart:html';

import 'package:angular_app/src/open_street_map.dart';
import 'package:angular_app/src/tracker_data_coupler.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:dartleaf/dartleaf.dart';

@Component(
    selector: "map2-app",
    templateUrl: "map.component2.html",
    directives: [coreDirectives, formDirectives],
    providers: [Provider(Services)])
class MapComponent2 implements AfterViewChecked {
  OpenStreetMap map;
  DrawTrackers _drawTrackers;
  Services _services = Services();
  List<TrackerDataCoupler> _trackersList = [];
  List<User> _usersList = [];
  MapComponent2(this._services) {
    _services.dataManager.getAllUsers().then((users) {
      _usersList = users;
    });
  }

  ngAfterViewChecked() {
    var qurt = querySelector('#output');
    if (qurt != null) {
      if (map == null) {
        map = OpenStreetMap("output");

        map.setView(lat: 15.6236417, lng: 32.5428738, zoom: 13);
        print(map.geoJson);

        querySelectorAll('input[name=drawOption]')
            .onClick
            .listen((MouseEvent e) {
          var btn = e.target as RadioButtonInputElement;
          map.draw(btn.id, btn.checked);
        });

        querySelector("#btnGetGeoJson").onClick.listen((_) {
          var json = map.geoJson;
          print(json);
        });
        _drawTrackers = DrawTrackers(map.getMap());
        _services.dataManager.getAliveLocations().then((data) {
          data.forEach((item) {
            if (!_trackersList.any((test) {
              return test.tracker.userId == item.userId;
            })) {
              print("init " +
                  item.currentLocation.lat.toString() +
                  "," +
                  item.currentLocation.long.toString());
              var _tracker = TrackerDataCoupler(item, _prepareMarker(item));

              _trackersList.add(_tracker);
              _drawTrackers.putTracker(_tracker.layer);
            }
            _services.dataManager.startTimer(timerHandler);
          });
        });
      }
    }
    //print(qurt.first.id);
    print("ngAfterViewChecked");
  }

  void timerHandler(Timer timer) {
    _services.dataManager.getAliveLocations().then((data) {
      data.forEach((item) {
        if (_trackersList != null &&
            item.currentLocation.lat != null &&
            item.currentLocation.long != null) {
          var tmpSingleTracker = _trackersList.singleWhere((tr) {
            return tr.tracker.userId == item.userId;
          });
          if (tmpSingleTracker != null) {
            _drawTrackers.removeTracker(tmpSingleTracker.layer);
            print("update" +
                item.currentLocation.lat.toString() +
                "," +
                item.currentLocation.long.toString());
            tmpSingleTracker.layer = _prepareMarker(item);
            _drawTrackers.putTracker(tmpSingleTracker.layer);
          } else {
            _drawTrackers.removeTracker(tmpSingleTracker.layer);
          }
        }
      });
    });
  }

  IconOptions userIcon(String userid) {
    var user = _usersList.firstWhere((first) {
      return first.id == userid;
    });
    var url;
    if (user.isToktokDriver) {
      url = 'assets/img/rickshaw.png';
    } else if (!user.isToktokDriver) {
      url = 'assets/img/house.png';
    } else {
      url = 'assets/img/leaf-green.png';
    }
    var options = IconOptions(
        shadowUrl: 'assets/img/leaf-shadow.png',
        iconUrl: url,
        iconSize: Point(40, 40), // size of the icon
        shadowSize: Point(50, 64), // size of the shadow
        // point of the icon which will correspond to marker's location
        iconAnchor: Point(10, 10),
        shadowAnchor: Point(4, 62), // the same for the shadow
// point from which the popup should open relative to the iconAnchor
        popupAnchor: Point(-3, -76));
    return options;
  }

  Marker _prepareMarker(Trackers tracker) {
    var pop = Popup()..setContent('<p>${tracker.userId}</p>');
    var marker = Marker(
        LatLng(tracker.currentLocation.lat, tracker.currentLocation.long),
        MarkerOptions(icon: Icon(userIcon(tracker.userId)), draggable: true));
    marker.bindPopup(pop);
    marker.bindTooltip("Click to learn more");
    return marker;
  }

  OnDestroy() {
    _services.dataManager.stopTimer();
  }
}
