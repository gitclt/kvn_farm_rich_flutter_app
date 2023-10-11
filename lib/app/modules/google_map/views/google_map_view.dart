import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';

import '../controllers/google_map_controller.dart';

class GoogleMapView extends GetView<GoogleMapsController> {
  const GoogleMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        label: "Google Map Place picker",
      ),
      body: GetBuilder<GoogleMapsController>(builder: (c) {
        return Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<GoogleMapsController>(
              builder: (contro) => Stack(
                clipBehavior: Clip.none,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          contro.position.latitude, contro.position.longitude),
                      zoom: 16,
                    ),
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: true,
                    onCameraIdle: () {
                      contro.dragableAddress();

                      //saving details when map is in idle state,
                      // you can store location detail in any variable also.

                      contro.addressList.add(
                          "${contro.address.name ?? ''}, ${contro.address.locality ?? ''} - ${contro.address.postalCode ?? ''}, ${contro.address.country ?? ''}");
                      contro.addressList
                          .add("\nLatitude: ${contro.position.latitude}");
                      contro.addressList
                          .add("Longitude: ${contro.position.longitude}");
                    },
                    onCameraMove: ((position) {
                      contro.addressList.clear();

                      //updating location when change in the marker
                      contro.updatePosition(position);
                    }),
                    onMapCreated: (GoogleMapController controller) {
                      contro.controller = controller;
                      if (contro.controller != null) {
                        //getting current location when map is initially displayed
                        contro.getCurrentLocation(
                            mapController: contro.controller);
                      }
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    right: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            contro.getCurrentLocation(
                                mapController: contro.controller);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.my_location,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //location marker surrounded with the loader
                  Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      child: const Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red,
                      )),
                  contro.loading
                      ? const Center(
                          child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ))
                      : Container(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                const Text(
                  'Map Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),

                //displaying location details
                for (int i = 0; i < c.addressList.length; i++)
                  Text(c.addressList[i].toString()),

                const SizedBox(
                  height: 10,
                ),

                c.addressList.isEmpty
                    ? const Center()
                    : BounceWidget(
                        onPressed: () {
                          c.picLocation();
                        },
                        child: Container(
                          width: 72,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffe51d28),
                          ),
                          child: const Center(
                            child: Text(
                              'UPDATE LOCATION',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ]);
      }),
    );
  }
}

class BounceWidget extends StatelessWidget {
  final Function? onPressed;
  final Widget child;
  const BounceWidget({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: const Duration(milliseconds: 100),
      scaleFactor: 1.5,
      child: child,
      onPressed: () {
        onPressed!();
      },
    );
  }
}
