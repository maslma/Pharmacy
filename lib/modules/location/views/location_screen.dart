// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  // start polyline
  // Map<MarkerId, Marker> markers = {};
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = "AIzaSyCJeVsHpH2TENN-v-4DLvKO41sklJ-YUXk";

  // End polyline

  // currentLocation
  late Position cl ;
  var lat;
  var long;
  CameraPosition? _kGooglePlex ;
  // هاد تحرك الموقع
  StreamSubscription<Position>? ps;

  // services Location = Enable => True or Disabled => False
  Future getPer() async
  {
    bool services ;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if(services == false)
    {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'services',
        desc: 'Services Not Enabled',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
    per = await Geolocator.checkPermission();
    if(per == LocationPermission.denied)
    {
      per = await Geolocator.requestPermission();
    }
    print(per);
    return per;
  }

  FutureOr<void> getLatAndLong() async
  {
   cl = await Geolocator.getCurrentPosition().then((value) => value);
   lat= cl.latitude;
   long= cl.longitude;
   _kGooglePlex =  CameraPosition(
     // المكان الي ببدا فيه الخريطة
     target: LatLng(lat, long),
     zoom: 14.4746,
     tilt: 59.440717697143555,
     bearing: 192.8334901395799,
   );
   mymarker.add(Marker(markerId: const MarkerId("1"),position:LatLng(lat, long), ));
   setState((){});
  }

@override
  void initState()
{
  // هاد الميثود تبعت تحرك مكان الموقع
  //  ps = Geolocator.getPositionStream().listen(
  //         (Position? position) {
  //           changemarker(position!.latitude , position.longitude);
  //     });
  getPer();
  getLatAndLong();
  // setMarkerCustomImage();
  //  getPolyline();
  super.initState();
}
// هاد لما نعرف صورة للموقع بنعرف بميثود وبنشغلها في initState
// setMarkerCustomImage()async
// {
//   mymarker.add(
//     Marker(
//       onTap: ()
//       {
//         print('Tap Home');
//       },
//       draggable:true,
//       onDragEnd:(LatLng t)
//       {
//         print('Drag End');
//       } ,
//       icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, ImagesManager.favorites),
//       markerId:MarkerId('1'),
//       position:LatLng(31.526248,34.464251),
//       infoWindow:InfoWindow(title:'Home' ),
//
//     ),
//   );
//}
  GoogleMapController? gmc;
  Set<Marker> mymarker =
  {
    Marker(
      visible:true, // ممكن نحطها false عشان ما تظهر
      onTap: ()
      {
        print('Tap Pharmacy');
      },
      draggable:true,
      onDragEnd:(LatLng t)
      {
        print('Drag End');
      } ,
      icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed) ,
      markerId:const MarkerId('1'),
    position:const LatLng(31.526056524934166,34.46461524814367), //LatLng(31.526248,34.464251)
      infoWindow:const InfoWindow(title:'Pharmacy' ),

    ),
  };

  // هاد ميثود بتغير مع تغير ال marker
  changemarker(newlat , newlong)
  {
    mymarker.clear();
    mymarker.add(Marker(markerId:const MarkerId("1"), position:LatLng(newlat,newlong)));
    gmc!.animateCamera(CameraUpdate.newLatLng(LatLng(newlat,newlong)));
    setState(()
    {});

  }
 // طريقة رسم الخط polyline
 //  addPolyLine() {
 //    PolylineId id = PolylineId("poly");
 //    Polyline polyline = Polyline(
 //      width:2 ,
 //        polylineId: id, color: Colors.red, points: polylineCoordinates);
 //    polylines[id] = polyline;
 //    setState(() {});
 //  }

  // getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPiKey,
  //       PointLatLng(31.5265240, 34.4634120), // start بداية الرسم
  //       PointLatLng(31.526056524934166, 34.46461524814367), // End نهاية الرسم
  //       travelMode: TravelMode.driving,
  //       // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
  //   );
  //   // if (result.points.isNotEmpty) {
  //   //   result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(31.5265240, 34.4634120));
  //       polylineCoordinates.add(LatLng(31.526056524934166, 34.46461524814367));
  //     // });
  //   // }
  //   addPolyLine();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children: [
          _kGooglePlex == null ?  const CircularProgressIndicator() :
          FadeInDown(
            delay:const Duration(milliseconds: 800) ,
            child: SizedBox(
              height:500.h, width: double.infinity,
              child: GoogleMap(
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                // polylines: Set<Polyline>.of(polylines.values),
                markers:mymarker ,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex!,
                // تستدعى هاد الميثود عندما الموقع تصبح جاهزة للاستخدام
                onMapCreated: (GoogleMapController controller) {
                  gmc = controller ;
                },
                // هاد بمعنى انو اذا بدنا نحذف الموقع الاول ونروح ع موقع تاني
                onTap: (latlan)
                {
                  mymarker.remove(const Marker(markerId:MarkerId("1") ));
                  mymarker.add(Marker(markerId:const MarkerId("1"), position:latlan));
                  setState(()
                  {
                    print(latlan);

                  });
                  },
              )),
          ),
          const Spacer(),
          Center(
            child: FadeInLeft(
              delay:const Duration(milliseconds:500 ) ,
              child: ElevatedButton(
                  onPressed: ()async
                  {
                    // نستخدم هاد عشان يحددلي موقع المكان
                    LatLng latlan = const LatLng(31.525840, 34.464480);
                    // gmc?.animateCamera(CameraUpdate.newLatLng(latlan));
                    gmc?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:latlan , zoom:19.151926040649414 ,tilt: 59.440717697143555,bearing: 192.8334901395799,  )));
                    // نستخدمها للاحداثيات المكان
                  // var xy = await gmc?.getLatLng(ScreenCoordinate(x: 200, y: 200));
                  // print(xy);
                  // هاد للاحداثيات ال zoom
                  // var zoom = await gmc?.getZoomLevel();
                  // print(zoom);

                    // هاد بجيب احداثيات المنطقة
                    //  getLatAndLong();
                    // print('Lat ${cl.latitude}');
                    // print('Long ${cl.longitude}');
                  //   // هاد بتجيب كل اشي بخص المكان
                  // List<Placemark> placemarks = await placemarkFromCoordinates(cl.latitude, cl.longitude);
                  // print(placemarks[0].country);
                  // // هاد بتجيب المسافة بين المنطقتين
                  // var distanceInMeters = Geolocator.distanceBetween(31.507091, 31.507478 ,35.090661, 35.092809);
                  // var distanceInkm = distanceInMeters / 1000; // بتحول المتر اللى كيلومتر
                  // print(distanceInkm);

                  },
                  child: const Text('Go To Pharmacy')),
            ),
          )
        ],
      ),
    );
  }
}


//AIzaSyCJeVsHpH2TENN-v-4DLvKO41sklJ-YUXk
// 31.526497 , 34.463377
//Lat 31.526521 , Long 34.4633953