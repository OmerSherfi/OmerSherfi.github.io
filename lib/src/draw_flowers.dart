import 'package:dartleaf/dartleaf.dart';
import 'draw.dart';

class DrawFlowers implements Draw {
  final LeafletMap _map;

  DrawFlowers(this._map);
  DrawFlowers.DeleteDrawFlowers(this._map);
  List<Layer> markerlist = [];
  @override
  set active(bool draw) {
    if (draw) {
      _map.on(E.click, _putLeaf);
    } else {
      _map.off(E.click);
    }
  }

  @override
  String get geoJson => "Not implemented";
  void _deleteLeaf(LeafletMouseEvent e) {
    if (markerlist.length > 1) {
      _map.removeLayer(markerlist[0]);
      markerlist.removeAt(0);
    }
  }

  void _putLeaf(LeafletMouseEvent e) {
    ;
    var options = IconOptions(
        shadowUrl: 'assets/img/leaf-shadow.png',
        iconUrl: 'assets/img/leaf-green.png',
        iconSize: Point(38, 95), // size of the icon
        shadowSize: Point(50, 64), // size of the shadow
        // point of the icon which will correspond to marker's location
        iconAnchor: Point(22, 94),
        shadowAnchor: Point(4, 62), // the same for the shadow
// point from which the popup should open relative to the iconAnchor
        popupAnchor: Point(-3, -76));

    var pop = Popup()..setContent('<p>Hello</p>');
    var marker =
        Marker(e.latlng, MarkerOptions(icon: Icon(options), draggable: true));
    marker.bindPopup(pop);
    marker.bindTooltip("Click to learn more");
    marker.addTo(_map);
    markerlist.add(marker);
    _deleteLeaf(e);
  }
}
