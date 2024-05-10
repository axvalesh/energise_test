import 'package:energise/constants/app_colors.dart';
import 'package:energise/screens/stopwatch/stopwatch_controller.dart';
import 'package:energise/widgets/ui/my_scaffold/my_scaffold.dart';
import 'package:energise/widgets/ui/my_text/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> with TickerProviderStateMixin {
  StopwatchController stopwatchController = Get.put(StopwatchController());

  late AnimationController _controllerButton;
  late Animation<double> _animationButton;
  late AnimationController _controllerText;
  late Animation<double> _animationText;

  @override
  void initState() {
    super.initState();

    _controllerButton = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animationButton = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _controllerButton,
        curve: Curves.bounceIn,
      ),
    );

    _controllerText = AnimationController(vsync: this,duration: Duration(milliseconds: 1000),);
    _animationText = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(
        parent: _controllerText,
        curve: Curves.bounceIn,
      ),);

    _controllerButton.repeat(reverse: true);
    _controllerText.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controllerButton.dispose();
    _controllerText.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MyScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          const Spacer(flex: 2,),
          AnimatedBuilder(
              animation: _animationText,
              builder: (context, child) {
              return Transform.scale(
                scale: _animationText.value,
                child: MyText(textVariant: TextVariants.bold,fontSize: 40, text: formatDuration(stopwatchController.elapsedTime.value),textColor: Colors.black,));
            }
          ),
          const Spacer(flex: 1,),
          InkWell(
            onTap: () {
              if(stopwatchController.isPlaying.value) {
                _controllerText.reset();
                stopwatchController.isPlaying.value = false;
                stopwatchController.pauseStopwatch();
                startButtonAnimation();
              } else {
                stopwatchController.elapsedTime.value = Duration.zero;
                _controllerButton.reset();
                stopwatchController.isPlaying.value = true;
                stopwatchController.startStopwatch();
                startTextAnimation();
              }
            },
            child: AnimatedBuilder(
              animation: _animationButton,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationButton.value,
                  child: Container(
                    width: width/2+30,
                    height: width/2+30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: stopwatchController.isPlaying.value ? AppColors.blue : AppColors.green
                    ),
                    alignment: Alignment.center,
                    child: Icon(stopwatchController.isPlaying.value ? Icons.pause : Icons.play_arrow,color: Colors.white,size: width/2,)
                  ),
                );
              }
            ),
          ),
          const Spacer(flex: 1,),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }


  void startTextAnimation() {
     _controllerText.dispose();
     _controllerText = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animationText = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _controllerText,
        curve: Curves.bounceIn,
      ),
    );

    _controllerText.repeat(reverse: true);
    setState(() {
      
    });
  }

  void startButtonAnimation() {
     _controllerButton.dispose();
     _controllerButton = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animationButton = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(
        parent: _controllerButton,
        curve: Curves.bounceIn,
      ),
    );

    _controllerButton.repeat(reverse: true);
    setState(() {
      
    });
  }

  
}