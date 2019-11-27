import 'package:dartleaf/dartleaf.dart';
import 'draw.dart';

class DrawTrackers implements Draw {
  final LeafletMap _map;

  DrawTrackers(this._map);

  @override
  set active(bool draw) {
    // if (draw) {
    //   _map.on(E.click, _putMarker);
    // } else {
    //   _map.off(E.click);
    // }
  }

  @override
  String get geoJson => "Not implemented";

  void putTracker(Layer marker) {
    marker.addTo(_map);
  }

  void removeTracker(Layer layer) {
    _map.removeLayer(layer);
  }
}
