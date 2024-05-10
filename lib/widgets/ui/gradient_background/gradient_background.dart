import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum gradientForPage {
  stopwatch,
  map,
  info,
}



class GradientBlurContainer extends StatefulWidget {
  final Widget givenChild;
  final gradientForPage gradienVariant;
  final int? index;
  final bool scrollable;
  const GradientBlurContainer({super.key, required this.givenChild, required this.gradienVariant, this.index, required this.scrollable});

  @override
  State<GradientBlurContainer> createState() => _GradientBlurContainerState();
}

class _GradientBlurContainerState extends State<GradientBlurContainer> {
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: GradientBlurContainerWrapper(
        givenChild: widget.scrollable ? SingleChildScrollView(
          physics : const ClampingScrollPhysics(),
          child: widget.givenChild) : widget.givenChild,
        gradienVariant: widget.gradienVariant,
        index: widget.index,
      ),
    );
  }
}

class GradientBlurContainerWrapper extends StatelessWidget {
  final Widget givenChild;
  final gradientForPage gradienVariant;
  final int? index;

  GradientBlurContainerWrapper({
    required this.givenChild,
    required this.gradienVariant,
    this.index, //for pages that has a few backgrounds
  });

  

  @override
  Widget build(BuildContext context) {
    switch (gradienVariant) {

      case(gradientForPage.stopwatch): return StopwatchBackground(givenChild: givenChild);
      case(gradientForPage.map): return MapScreenBackogrund(givenChild: givenChild);
      case(gradientForPage.info): return InfoScreenBackground(givenChild: givenChild);

      default:
      return Container(
        child: givenChild,
      );
  }
  }
}


class StopwatchBackground extends StatelessWidget {
  const StopwatchBackground({
    super.key,
    required this.givenChild,
  });

  final Widget givenChild;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
          
         Animate(
          effects:  [
                const FadeEffect(duration: Duration(milliseconds: 200))
              ],
           child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
             child: Container(
              color: Colors.white,
              child: CustomPaint(
                size: Size(width,height),
                painter: IncomePaintRectangle(
                  incomeData: [
                    DrawPointsRectangle(
                      x: width-135, 
                      y: -60,
                      color1: const Color(0xffADF0FF), 
                      color2: const Color(0xff25C5E8),
                      height: 270,
                    ),
                    DrawPointsRectangle(
                      x: 0, 
                      y: height*0.35,
                      color1: const Color(0xffD6F99E), 
                      color2: const Color(0xff70A9FF).withOpacity(0.41),
                      height: 250,
                    ),
                    DrawPointsRectangle(
                      x: width-60, 
                      y: height*0.65,
                      color1: const Color(0xffFFD885), 
                      color2: const Color(0xffFFECC2),
                      height: 250,
                    ),
                    DrawPointsRectangle(
                      x: 40, 
                      y: height-125,
                      color1: const Color(0xffC5C3DD), 
                      color2: const Color(0xffF5F5F9),
                      height: 250,
                    ),
                    DrawPointsRectangle(
                      x: width-140, 
                      y: height+60,
                      color1: const Color(0xffB2D8AC), 
                      color2: const Color(0xffF4F9F3),
                      height: 250,
                    ),
                    
                    
              
                    
           
                  ]
                ),
              )
              ),
           ),
         ),

        // Given child on top
        Container(child: givenChild),
      ],
    );
  }
}


class MapScreenBackogrund extends StatelessWidget {
  const MapScreenBackogrund({
    super.key,
    required this.givenChild,
  });

  final Widget givenChild;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
          
         Animate(
           effects:  [
                const FadeEffect(duration: Duration(milliseconds: 200))
              ],
           child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
             child: Container(
              color: Colors.white,
              child: CustomPaint(
                size: Size(width,height),
                painter: IncomePaintRectangle(
                  incomeData: [
                    DrawPointsRectangle(
                      x: 0, 
                      y: 0,
                      color1: const Color(0xff4FDFFF), 
                      color2: const Color(0xff94FFDF),
                      height: 240,
                      angle: 0.314159,
                    ),
           
                    
                    DrawPointsRectangle(
                      x: 0, 
                      y: height*0.5,
                      color1: const Color(0xffFFD885), 
                      color2: const Color(0xffFFECC2),
                      height: 270,
                      angle: 1.43117,
                    ),
           
                    DrawPointsRectangle(
                      x: width*0.8, 
                      y: height*0.8,
                      color1: const Color(0xff4EFFBF), 
                      color2: const Color(0xff6699FE).withOpacity(0.6),
                      height: 270,
                      angle: 0.610865,
                    ),
                    
                
                    
              
                    
           
                  ]
                ),
              )
              ),
           ),
         ),

        // Given child on top
        Container(child: givenChild),
      ],
    );
  }
}



class InfoScreenBackground extends StatelessWidget {
  const InfoScreenBackground({
    super.key,
    required this.givenChild,
  });

  final Widget givenChild;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
          
         Animate(
          effects:  [
                const FadeEffect(duration: Duration(milliseconds: 200))
              ],
           child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
             child: Container(
              color: Colors.white,
              child: CustomPaint(
                size: Size(width,height),
                painter: IncomePaintRectangle(
                  incomeData: [
                    DrawPointsRectangle(
                      x: width-20, 
                      y: 10,
                      color1: const Color(0xff4FDFFF), 
                      color2: const Color(0xff33B01F),
                      height: 250,
                      angle: 0.314159
                    ),
           
                    DrawPointsRectangle(
                      x: 0, 
                      y: height/2,
                      color1: const Color(0xffFFD885), 
                      color2: const Color(0xffFFECC2),
                      height: 270,
                      angle: -2
                    ),
           
                    DrawPointsRectangle(
                      x: width*0.8, 
                      y: height*0.8,
                      color2: const Color(0xffFBFF4E), 
                      color1: const Color(0xffBAB4FF).withOpacity(0.6),
                      height: 270,
                      angle: 35
                    ),
                    
              
                    
           
                  ]
                ),
              )
              ),
           ),
         ),

        // Given child on top
        Container(child: givenChild),
      ],
    );
  }
}


class DrawPoints {

  final double x;
  final double y;
  final Color color;
  final double radius;

  DrawPoints({
    required this.x,
    required this.y,
    required this.color,
    required this.radius,
  });
}

class IncomePaint extends CustomPainter {
  final List<DrawPoints> incomeData;

  IncomePaint({
    required this.incomeData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (DrawPoints point in incomeData) {
      Paint paint = Paint()
        ..color = point.color.withOpacity(0.85)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(point.x, point.y), point.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class DrawPointsRectangle {
  final double x;
  final double y;
  final double height;
  final double angle; // Rotation angle in radians
  final Color color1;
  final Color color2;

  DrawPointsRectangle({
    required this.x,
    required this.y,
    required this.height,
    this.angle = 0, // Default to no rotation
    required this.color1,
    this.color2 = Colors.transparent,
  });
}

class IncomePaintRectangle extends CustomPainter {
  final List<DrawPointsRectangle> incomeData;

  IncomePaintRectangle({
    required this.incomeData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;
    double width = size.width;
    for (DrawPointsRectangle point in incomeData) {

      double itemSize = point.height/375*width;
      Paint paint;
      if (point.color2 == Colors.transparent) {
        paint = Paint()
          ..color = point.color1.withOpacity(0.85)
          ..style = PaintingStyle.fill;
      } else {
        paint = Paint()
          ..shader = LinearGradient(
            colors: [point.color1, point.color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromPoints(Offset(-itemSize / 2, -itemSize / 2),
                                         Offset(itemSize / 2, itemSize / 2)))
          ..style = PaintingStyle.fill;
      }

      canvas.save(); // Save the canvas state before applying rotation
      canvas.translate(point.x, point.y); // Translate to the rectangle's center
      canvas.rotate(point.angle); // Rotate the canvas
      canvas.drawRect(
        Rect.fromPoints(
          Offset(-itemSize / 2, -itemSize / 2),
          Offset(itemSize / 2, itemSize / 2),
        ),
        paint,
      );
      
      canvas.restore(); // Restore the canvas state after drawing the rectangle
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}