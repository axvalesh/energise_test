import 'package:get/get.dart';
import 'package:energise/constants/languages/english.dart';
import 'package:energise/constants/languages/ukrainian.dart';

enum Languages {
  ukrainian,english
}
class GlobalController extends GetxController {
  RxMap<dynamic,dynamic> currentMapLanguage = {}.obs;
  Rx<Languages> currentLanguage = Languages.ukrainian.obs;

  void updateCurrentLanguage() {
    GlobalController globalController = Get.put(GlobalController());
    if(globalController.currentLanguage == Languages.english) {
      globalController.currentMapLanguage.value = englishMapLanguage;
    } else if(globalController.currentLanguage == Languages.ukrainian) {
      globalController.currentMapLanguage.value = ukrainianMapLanguage;
    }
  }
}