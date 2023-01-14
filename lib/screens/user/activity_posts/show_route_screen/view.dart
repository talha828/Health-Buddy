import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

class ShowRouteScreen extends StatefulWidget {
  LatLng startPosition;
  LatLng endPosition;
  ShowRouteScreen({Key? key,required this.startPosition,required this.endPosition}) : super(key: key);

  @override
  State<ShowRouteScreen> createState() => _ShowRouteScreenState();
}

class _ShowRouteScreenState extends State<ShowRouteScreen> {
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  //Set<Polyline> set={Polyline(polylineId: PolylineId("ss"),points: [ LatLng(40.484000837597925, -3.369978368282318),LatLng(40.48017307700204, -3.3618026599287987)],),};
  temp()async{
    PolylinePoints polylinePoints = PolylinePoints();
    //PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyAegpKmjI8t6TKkExJemvelCHAyKoo",
        //PointLatLng(widget.currentPosition.latitude, widget.currentPosition.longitude),PointLatLng(widget.targetPosition.latitude, widget.targetPosition.longitude), wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],travelMode: TravelMode.walking);
    //print(result.points);
    //result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(widget.startPosition.latitude, widget.startPosition.longitude));
      polylineCoordinates.add(LatLng(widget.endPosition.latitude, widget.endPosition.longitude));
    //});
    setState(() {});
    _addPolyLine();
  }


  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }
  @override
  void initState() {
    temp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Center(
            child: Text(
              "Route",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        body: GoogleMapsWidget(
          key: mapsWidgetController,
          updatePolylinesOnDriverLocUpdate: true,
          routeWidth: 5,
          showPolyline:true ,
          apiKey: "AIzaSyAegpKmjI8t6TKkExJemvelCHAyKoo",
          polylines:Set<Polyline>.of(polylines.values),
          sourceLatLng: widget.startPosition,
          destinationLatLng:widget.endPosition,
        ),
      ),
    );
  }
}
