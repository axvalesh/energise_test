import 'package:energise/constants/app_colors.dart';
import 'package:energise/routes.dart';
import 'package:energise/widgets/ui/gradient_background/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final bool? ignoreSafeArea;
  final bool? scrollable;
  const MyScaffold({super.key, required this.body, this.ignoreSafeArea = false, this.scrollable = false});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> with TickerProviderStateMixin {
  var _bottomNavIndex = 0;
  bool isVisible = false;
  Map<String,int> screensMapInt = {
    Routes.stopwatch: 0,
    Routes.map: 1,
    Routes.info: 2,
  };
   Map<String,gradientForPage> screensMapBackground = {
    Routes.stopwatch: gradientForPage.stopwatch,
    Routes.map: gradientForPage.map,
    Routes.info: gradientForPage.info,
  };


  @override
  void initState() {
    super.initState();
    String currentRoute = Get.currentRoute;
    _bottomNavIndex = screensMapInt[currentRoute] ?? 0;
      
    setState(() {
      
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            isVisible = true;
          });
        });
      });
    
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBody: true,
      body: GradientBlurContainer(
        scrollable: widget.scrollable!,
        givenChild: widget.ignoreSafeArea! ? AnimatedOpacity(
           duration: Duration(milliseconds: 300),
          opacity: isVisible ? 1 : 0,
          child: widget.body) : AnimatedOpacity(
             duration: Duration(milliseconds: 300),
          opacity: isVisible ? 1 : 0,
            child: SafeArea(
            child: widget.body,
                    ),
          ),
        gradienVariant: screensMapBackground[Get.currentRoute] ?? gradientForPage.stopwatch,
      ),
      bottomNavigationBar: Container(
        height: safePadding+ 70,
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.topCenter,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.5),
            
            border: Border.all(color: Colors.black.withOpacity(0),width: 1)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomIcon(icon: Icons.home,color: _bottomNavIndex == 0 ? AppColors.green : Colors.black,route: Routes.stopwatch,),
              BottomIcon(icon: Icons.map_outlined,color: _bottomNavIndex == 1 ? AppColors.green : Colors.black,route: Routes.map,),
              BottomIcon(icon: Icons.info_outline,color: _bottomNavIndex == 2 ? AppColors.green : Colors.black,route: Routes.info,),
            ],
          ),
        ),
      )
    );
  }
}

class BottomIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String route;
  const BottomIcon({super.key, required this.icon, required this.color, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        width: 70,
        height: 48,
        color: Colors.transparent,
        child: Icon(icon,size: 30,color: color,)),
    );
  }
}


