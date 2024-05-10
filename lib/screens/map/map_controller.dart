import 'dart:convert';

import 'package:energise/common/shared_preferences.dart';
import 'package:energise/models/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Rx<LatLng> currentUserPosition = LatLng(37.42796133580664, -122.085749655962).obs;
  Rx<IPGeolocation> userInfo = IPGeolocation().obs;
  final MySharedPreferences mySharedPreferences = MySharedPreferences();


  Future<void> getUserIP(bool ignoreCaching) async {

  try {

    final String? jsonData = await mySharedPreferences.getDataIfNotExpired();
    if(jsonData != null && !ignoreCaching) {
      userInfo.value = IPGeolocation.fromJson(json.decode(jsonData));
      if(userInfo.value.lat != null && userInfo.value.lon != null) {
        currentUserPosition.value = LatLng(userInfo.value.lat!, userInfo.value.lon!);
      }
      debugPrint('got data from cache ${jsonData}');
      return;
    }
    var response = await http.get(Uri.parse('http://ip-api.com/json/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query'));
    if (response.statusCode == 200) {
      
      Map<String, dynamic> data = json.decode(response.body);
      userInfo.value = IPGeolocation.fromJson(data);
      
      if(userInfo.value.lat != null && userInfo.value.lon != null) {
        currentUserPosition.value = LatLng(userInfo.value.lat!, userInfo.value.lon!);
      }

      final isSaved = await mySharedPreferences.saveDataWithExpiration(
            response.body, const Duration(days: 10));
      debugPrint('response is $data');
      return;
    } else {
      // Handle errors
      print('Failed to get IP address: ${response.statusCode}');
      return;
    }
  } catch (e) {
    print('Error getting IP address: $e');
    return;
  }
}
}