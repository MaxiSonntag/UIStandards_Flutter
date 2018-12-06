import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';

class MapPage extends StatefulWidget {
  @override
  State createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  GoogleMapController googleMapController;
  final _iNovationGeo = LatLng(49.674812, 12.156867);
  final _appleGeo = LatLng(37.332279, -122.030762);
  final _googleGeo = LatLng(37.422179, -122.083714);
  final _locations = List<LatLng>();
  var _selectedLocIdx = 0;
  final _markers = List<Marker>();
  var _selectedMarker;
  GoogleMapOptions _options;
  TargetPlatform platform;
  CameraPosition _position;

  @override
  void initState() {
    super.initState();
    platform = Platform.isAndroid ? TargetPlatform.android : TargetPlatform.iOS;
    _locations.add(_iNovationGeo);
    _locations.add(_appleGeo);
    _locations.add(_googleGeo);
    print("Platform: $platform");
    _options = GoogleMapOptions(
      cameraPosition: CameraPosition(
          target: _iNovationGeo, tilt: 30.0, zoom: 17.0, bearing: 15.0),
      compassEnabled: false,
      myLocationEnabled: false,
      rotateGesturesEnabled: true,
      zoomGesturesEnabled: true,
      trackCameraPosition: true,
    );
  }

  _mapChangedListener() {
    setState(() {
      _options = googleMapController.options;
      _position = googleMapController.cameraPosition;
    });
  }

  _selectedMarkerChangedListener(Marker marker){
    if(_selectedMarker != null){
      googleMapController.updateMarker(_selectedMarker, MarkerOptions(
        icon: BitmapDescriptor.defaultMarker
      ));
    }
    setState(() {
      _selectedMarker = marker;
    });
    googleMapController.updateMarker(marker, MarkerOptions(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    ));
  }

  Widget _compassToggler() {
    return FlatButton(
      child: Text("${_options.compassEnabled ? 'Disable' : 'Enable'} compass"),
      onPressed: () {
        googleMapController.updateMapOptions(
            GoogleMapOptions(compassEnabled: !_options.compassEnabled));
      },
    );
  }

  Widget _myLocationToggler() {
    return FlatButton(
      child: Text(
          "${_options.myLocationEnabled ? 'Disable' : 'Enable'} my location"),
      onPressed: () {
        _checkLocationPermissions(platform).then((res) {
          if (res) {
            googleMapController.updateMapOptions(GoogleMapOptions(
                myLocationEnabled: !_options.myLocationEnabled));
          }
        });
      },
    );
  }

  Future<bool> _checkLocationPermissions(TargetPlatform target) async {
    Permission requiredPermission;
    if (target == TargetPlatform.android) {
      requiredPermission = Permission.AccessFineLocation;
    } else {
      requiredPermission = Permission.WhenInUseLocation;
    }

    final granted = await SimplePermissions.checkPermission(requiredPermission);
    if (!granted) {
      final result =
          await SimplePermissions.requestPermission(requiredPermission);
      return PermissionStatus.authorized == result;
    }
    return granted;
  }

  Widget _rotationToggler() {
    return FlatButton(
      child: Text(
          "${_options.rotateGesturesEnabled ? 'Disable' : 'Enable'} rotation"),
      onPressed: () {
        googleMapController.updateMapOptions(GoogleMapOptions(
            rotateGesturesEnabled: !_options.rotateGesturesEnabled));
      },
    );
  }

  Widget _zoomToggler() {
    return FlatButton(
      child:
          Text("${_options.zoomGesturesEnabled ? 'Disable' : 'Enable'} zoom"),
      onPressed: () {
        googleMapController.updateMapOptions(GoogleMapOptions(
            zoomGesturesEnabled: !_options.zoomGesturesEnabled));
      },
    );
  }

  Widget _locationToggler() {
    return FlatButton(
      child: Text("Change location animated"),
      onPressed: () {
        setState(() {
          _selectedLocIdx++;
        });
        googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: _locations[(_selectedLocIdx) % _locations.length],
          tilt: 30.0,
          zoom: 17.0,
        )));
        /*googleMapController.updateMapOptions(
          GoogleMapOptions(
            cameraPosition: CameraPosition(
              target: _locations[_selectedLocIdx % _locations.length],
              tilt: 30.0,
              zoom: 17.0,
            )
          )
        );*/
      },
    );
  }

  Widget _addMarker(){
    return FlatButton(
      child: Text("Add marker"),
      onPressed: (){
        _createMarker().then((marker){
          _markers.add(marker);
        });
      },
    );
  }

  Future<Marker> _createMarker() async {
    final infoText = _getInfoTextForMarker(_position.target);
    return googleMapController.addMarker(MarkerOptions(
        position: _position.target,
        infoWindowText: InfoWindowText(infoText, ""),
        alpha: 1.0,
        visible: true,
        icon: BitmapDescriptor.defaultMarker,
    ));
  }

  String _getInfoTextForMarker(LatLng pos){
    
    final lat = double.parse(pos.latitude.toStringAsFixed(6));
    final lng = double.parse(pos.longitude.toStringAsFixed(6));
    if(_locations.contains(LatLng(lat, lng))){
      switch(_selectedLocIdx % _locations.length){
        case 0: return "i-novation Weiden";
        case 1: return "Apple Infinite Loop";
        default: return "Googleplex";
      }
    }
    return "No info available";
  }

  Widget _removeMarkers(){
    return FlatButton(
      child: Text("Remove all markers"),
      onPressed: (){
        _markers.forEach((marker){
          googleMapController.removeMarker(marker);
        });
        _markers.clear();
        _selectedMarker = null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: GoogleMap(
                onMapCreated: (ctrl) {
                  googleMapController = ctrl;
                  googleMapController.addListener(_mapChangedListener);
                  googleMapController.onMarkerTapped.add(_selectedMarkerChangedListener);
                },
                options: _options,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              _compassToggler(),
              _myLocationToggler(),
              _rotationToggler(),
              _zoomToggler(),
              _locationToggler(),
              _addMarker(),
              _removeMarkers()
            ],
          ),
        )
      ],
    );
  }
}
