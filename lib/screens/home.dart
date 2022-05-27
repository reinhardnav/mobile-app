import 'package:capex_mobile/providers/ProfileAuthentication.dart';
import 'package:capex_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:capex_mobile/widgets/app_drawer.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capex_mobile/services/authentication.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as goo;

Geoflutterfire geo = Geoflutterfire();
Firestore _firestore = Firestore.instance;
Position position_current;

class Homepage extends StatefulWidget {
  Homepage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  String searchAddrOri;
  String searchAddrDesti;

  goo.LatLng myLocation;

  String fullname, email, uid;
  String origin, destination;
  ProfileAuth authProvider;

  goo.BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    getUserData(context);
  }

  void saveFireStore(lat, lng) {
    GeoFirePoint myLocation = geo.point(latitude: lat, longitude: lng);

    _firestore
        .collection('locations')
        .document(this.uid)
        .setData({'position': myLocation.data});
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      authProvider = Provider.of<ProfileAuth>(context, listen: false);
      authProvider.pinLocationIcon = this.pinLocationIcon;

      authProvider.getUser().then((data) {
        this.fullname = data.displayName;
        this.email = data.email;
        this.uid = data.uid;
        print("userdata");
        print(this.fullname);
        print(this.email);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> getMyLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    myLocation = goo.LatLng(position.latitude, position.longitude);
    saveFireStore(position.latitude, position.longitude);
    /*this.setState(() {
      *_markers.clear();

      _markers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: myLocation,
          builder: (ctx) => Container(
            child: Row(
              children: <Widget>[
                Container(
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset(
                      "assets/images/motor.png",
                      height: 60,
                      width: 60,
                    )),
              ],
            ),
          ),
        ),
      );
    });*/
    position_current = position;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final authProvider = Provider.of<ProfileAuth>(context, listen: false);
    var data = getMyLocation();
    var current;
    if (position_current == null) {
      current = goo.LatLng(14.7128, 120.9999);
    } else {
      current =
          goo.LatLng(position_current.latitude, position_current.longitude);
    }

    /*return Scaffold(
      drawer:
          AppDrawer(email: this.email, fullname: this.fullname, uid: this.uid),
      body: goo.GoogleMap(
        initialCameraPosition: goo.CameraPosition(target: current, zoom: 10.0),
        onMapCreated: authProvider.onCreated,
        myLocationEnabled: true,
        mapType: goo.MapType.normal,
        compassEnabled: true,
        markers: authProvider.markers,
        onCameraMove: authProvider.onCameraMove,
        polylines: authProvider.polyLines,
      ),
      Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ],
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: authProvider.locationController,
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "pick up",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 105.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ],
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: authProvider.destinationController,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    authProvider.sendRequest(value);
                  },
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.local_taxi,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "destination?",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
            ),
    );*/
    /*return SafeArea(
      child: authProvider.initialPosition == null
          ? Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRotatingCircle(
                      color: Colors.black,
                      size: 50.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: authProvider.locationServiceActive == false,
                  child: Text(
                    "Please enable location services!",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                )
              ],
            ))
          : Stack(
              children: <Widget>[
                goo.GoogleMap(
                  initialCameraPosition: goo.CameraPosition(
                      target: authProvider.initialPosition, zoom: 10.0),
                  onMapCreated: authProvider.onCreated,
                  myLocationEnabled: true,
                  mapType: goo.MapType.normal,
                  compassEnabled: true,
                  markers: authProvider.markers,
                  onCameraMove: authProvider.onCameraMove,
                  polylines: authProvider.polyLines,
                ),
                Positioned(
                  top: 50.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: authProvider.locationController,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "pick up",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 105.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: authProvider.destinationController,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        authProvider.sendRequest(value);
                      },
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.local_taxi,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "destination?",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    )
    ;*/

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      backgroundColor: lprimaryColor,
      appBar: AppBar(
//        backgroundColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: lprimaryColor,
          elevation: 20,
          title: Text("CaPEx Mobile"),
          iconTheme: new IconThemeData(color: Colors.white)),
      drawer:
          AppDrawer(email: this.email, fullname: this.fullname, uid: this.uid),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 85,
                  child: goo.GoogleMap(
                    initialCameraPosition:
                        goo.CameraPosition(target: current, zoom: 15.0),
                    onMapCreated: authProvider.onCreated,
                    myLocationEnabled: true,
                    mapType: goo.MapType.normal,
                    compassEnabled: true,
                    markers: authProvider.markers,
                    onCameraMove: authProvider.onCameraMove,
                    polylines: authProvider.polyLines,
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  left: 10.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      controller: authProvider.locationController,
                      onTap: () async {
                        Prediction d = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: "AIzaSyDDkoufd1E703G1vnzcI70sHf_eR_PeV3Y",
                            language: "en",
                            components: [Component(Component.country, "ph")]);
                        if (d != null) {
                          print("Origin : ");
                          print(d.description);
                          //authProvider.sendRequest(d.toString());
                          searchAddrOri = d.toString();
                        }
                      },
                      decoration: new InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 10, top: 0),
                          width: 10,
                          height: 20,
                          child: Icon(
                            Icons.location_on,
                            color: lprimaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Pickup Location",
                        contentPadding: EdgeInsets.only(left: 15.0, top: 0.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70.0,
                  right: 10.0,
                  left: 10.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                        onTap: () async {
                          Prediction d = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: "AIzaSyDDkoufd1E703G1vnzcI70sHf_eR_PeV3Y",
                              language: "en",
                              components: [Component(Component.country, "ph")]);
                          if (d != null) {
                            authProvider.sendRequest(d.toString());
                            print("{$searchAddrOri}");
                          }
                        },
                        cursorColor: Colors.black,
                        controller: authProvider.destinationController,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          authProvider.sendRequest(value);
                        },
                        decoration: new InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 10, top: 0),
                            width: 10,
                            height: 20,
                            child: Icon(
                              Icons.location_on,
                              color: lprimaryColor,
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Delivery Location",
                          contentPadding: EdgeInsets.only(left: 15.0, top: 0.0),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setCustomMapPin() async {
    pinLocationIcon = await goo.BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/motor.png');
  }
}
