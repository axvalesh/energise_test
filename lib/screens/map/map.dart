import 'package:energise/common/global_controller.dart';
import 'package:energise/constants/app_colors.dart';
import 'package:energise/models/geolocation.dart';
import 'package:energise/screens/map/map_controller.dart';
import 'package:energise/widgets/ui/my_button/my_button.dart';
import 'package:energise/widgets/ui/my_dialog/my_dialog.dart';
import 'package:energise/widgets/ui/my_scaffold/my_scaffold.dart';
import 'package:energise/widgets/ui/my_text/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {

  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = Get.put(MapController());
  GlobalController globalController = Get.put(GlobalController());
  late GoogleMapController _controller;
  LatLng _center = const LatLng(0, 0);
  bool isLoading = false;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    getCameraPosition();
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.bottom;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(() =>  Stack(
      children: [
        MyScaffold(
          ignoreSafeArea: true,
          scrollable: true,
          body: Column(
            children: [
              const Row(),
              Container(
                height: height-safePadding-200,
                decoration: BoxDecoration(
                  boxShadow: [
                   BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.7),
          
                      spreadRadius: 1,
                    )
                  ]
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  onCameraMove: _onCameraMove,
                 
                  initialCameraPosition: CameraPosition(
                    target: mapController.currentUserPosition.value,
                    zoom: 14.4746,
                  ),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
              const SizedBox(height: 30,),
          
          
              SizedBox(
                width: width,
                child: Row(
                  children: [
                    const SizedBox(width: 20,),
                    MyButton(text: globalController.currentMapLanguage["details"], onClick: () {
                      showDialog(context: context, builder: (value) {
                        return MyDialog(
                          body: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child:InfoBoxColumn(data: mapController.userInfo.value,)
                          ),
                        );
                      });
                    },width: width/2-30,color: AppColors.blue,),
                    const SizedBox(width: 20,),
                    MyButton(text: globalController.currentMapLanguage["reload"], onClick: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await mapController.getUserIP(true);
                      setState(() {
                        isLoading = false;
                      });
                    },width: width/2-30,),
                    const SizedBox(width: 20,),
                  ],
                ),
              )
              
            ],
          ),
        ),
        isLoading ? Positioned.fill(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.black.withOpacity(0.2),
              child: Center(child: CircularProgressIndicator(color: AppColors.green,),),
            ),
          ) : SizedBox(),
      ],
    ));
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
    _updateMarkers();
  }

  void _updateMarkers() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(_center.toString()),
        position: _center,
        infoWindow: InfoWindow(
          title: 'Center Marker',
          snippet: 'Lat: ${_center.latitude}, Lng: ${_center.longitude}',
        ),
      ),
    );
    setState(() {});
  }


  void getCameraPosition() {
    LatLng baseCoordinates = const LatLng(37.42796133580664, -122.085749655962);
    if(mapController.currentUserPosition.value.latitude == baseCoordinates.latitude && mapController.currentUserPosition.value.longitude == baseCoordinates.longitude) {
      debugPrint('if');
      mapController.getUserIP(false).then((value) {
        debugPrint('new position is ${mapController.currentUserPosition.value}');
         _controller.moveCamera(CameraUpdate.newLatLng(mapController.currentUserPosition.value));
      });
    }
  }
}

class InfoBoxColumn extends StatefulWidget {
  final IPGeolocation data;

  const InfoBoxColumn({Key? key, required this.data}) : super(key: key);

  @override
  State<InfoBoxColumn> createState() => _InfoBoxColumnState();
}

class _InfoBoxColumnState extends State<InfoBoxColumn> {
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (widget.data.status != null) _buildInfoBox(title: globalController.currentMapLanguage["status"] ?? 'Status', text: widget.data.status!),
      if (widget.data.continentCode != null) _buildInfoBox(title: globalController.currentMapLanguage["continentCode"] ?? 'Continent code', text: widget.data.continentCode!),
      if (widget.data.country != null) _buildInfoBox(title: globalController.currentMapLanguage["country"] ?? 'Country', text: widget.data.country!),
      if (widget.data.countryCode != null) _buildInfoBox(title: globalController.currentMapLanguage["countryCode"] ?? 'Country Code', text: widget.data.countryCode!),
      if (widget.data.region != null) _buildInfoBox(title: globalController.currentMapLanguage["region"] ?? 'Region', text: widget.data.region!),
      if (widget.data.regionName != null) _buildInfoBox(title: globalController.currentMapLanguage["regionName"] ?? 'Region Name', text: widget.data.regionName!),
      if (widget.data.city != null) _buildInfoBox(title: globalController.currentMapLanguage["city"] ?? 'City', text: widget.data.city!),
      if (widget.data.district != null) _buildInfoBox(title: globalController.currentMapLanguage["district"] ?? 'District', text: widget.data.district!),
      if (widget.data.zip != null) _buildInfoBox(title: globalController.currentMapLanguage["zip"] ?? 'Zip Code', text: widget.data.zip!),
      if (widget.data.lat != null) _buildInfoBox(title: globalController.currentMapLanguage["latitude"] ?? 'Latitude', text: widget.data.lat!.toString()),
      if (widget.data.lon != null) _buildInfoBox(title: globalController.currentMapLanguage["longitude"] ?? 'Longitude', text: widget.data.lon!.toString()),
      if (widget.data.timezone != null) _buildInfoBox(title: globalController.currentMapLanguage["timezone"] ?? 'Timezone', text: widget.data.timezone!),
      if (widget.data.offset != null) _buildInfoBox(title: globalController.currentMapLanguage["offset"] ?? 'Offset', text: widget.data.offset!.toString()),
      if (widget.data.currency != null) _buildInfoBox(title: globalController.currentMapLanguage["currency"] ?? 'Currency', text: widget.data.currency!),
      if (widget.data.isp != null) _buildInfoBox(title: globalController.currentMapLanguage["isp"] ?? 'ISP', text: widget.data.isp!),
      if (widget.data.org != null) _buildInfoBox(title: globalController.currentMapLanguage["org"] ?? 'Organization', text: widget.data.org!),
      if (widget.data.fieldAs != null) _buildInfoBox(title: globalController.currentMapLanguage["as"] ?? 'AS Field', text: widget.data.fieldAs!),
      if (widget.data.asname != null) _buildInfoBox(title: globalController.currentMapLanguage["asname"] ?? 'AS Name', text: widget.data.asname!),
      if (widget.data.reverse != null) _buildInfoBox(title: globalController.currentMapLanguage["reverse"] ?? 'Reverse DNS', text: widget.data.reverse!),
      if (widget.data.mobile != null) _buildInfoBox(title: globalController.currentMapLanguage["mobile"] ?? 'Mobile', text: widget.data.mobile!.toString()),
      if (widget.data.proxy != null) _buildInfoBox(title: globalController.currentMapLanguage["proxy"] ?? 'Proxy', text: widget.data.proxy!.toString()),
      if (widget.data.hosting != null) _buildInfoBox(title: globalController.currentMapLanguage["hosting"] ?? 'Hosting', text: widget.data.hosting!.toString()),
      if (widget.data.query != null) _buildInfoBox(title: globalController.currentMapLanguage["query"] ?? 'Query', text: widget.data.query!),

      ],
    );
  }

  Widget _buildInfoBox({required String title, required String text}) {
    if(text == '') return SizedBox();
    return InfoBox(title: title, text: text);
  }
}



class InfoBox extends StatelessWidget {
  final String title;
  final String text;
  const InfoBox({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,

      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(child: MyText(textVariant: TextVariants.bold, text: '$title:')),
          SizedBox(width: 10,),
          Expanded(child: MyText(textVariant: TextVariants.bold, text: text))
        ],
      ),
    );
  }
}