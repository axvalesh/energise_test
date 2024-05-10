import 'package:energise/common/global_controller.dart';
import 'package:energise/routes.dart';
import 'package:energise/screens/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapController mapController = Get.put(MapController(),permanent: true);
  GlobalController globalController = Get.put(GlobalController(),permanent: true);
  globalController.updateCurrentLanguage();
  mapController.getUserIP(false);
  runApp(const MainApp());
}




class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.stopwatch,
          getPages: getPages,
          theme: ThemeData(
            fontFamily: 'Circe',
            colorScheme: ColorScheme.fromSwatch().copyWith(
              // ignore: deprecated_member_use
              background: Colors.white,
            ),

            textTheme: const TextTheme(        
              titleMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Color.fromARGB(255, 0, 0, 0)),
              
              bodyLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Color.fromARGB(255, 0, 0, 0)), 
             
            ),
          ),
    );
  }
}
