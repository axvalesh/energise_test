import 'package:energise/common/global_controller.dart';
import 'package:energise/widgets/ui/my_button/my_button.dart';
import 'package:energise/widgets/ui/my_scaffold/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>  MyScaffold(
      body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    globalController.currentLanguage.value = Languages.ukrainian;
                    globalController.updateCurrentLanguage();
                  },
                  child: Image.asset('assets/images/Ukraine.png',height: 50,width: 50,)),
                InkWell(
                  onTap: () {
                    globalController.currentLanguage.value = Languages.english;
                    globalController.updateCurrentLanguage();
                  },
                  child: Image.asset('assets/images/Britain.png',height: 50,width: 50,)),
              ],
            ),
          ),
          SizedBox(height: 30,),
          MyButton(text: globalController.currentMapLanguage['rate app'], onClick: () {
            showDialog(context: context, builder: (value) {
              return Center(
                child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              Navigator.of(context).pop();
                print(rating);
                // You can use the rating value here as needed
                            },
                          ),
              );
            });
          }),
          SizedBox(height: 15,),
          MyButton(text: globalController.currentMapLanguage['share app'], onClick: () async {

            final result = await Share.share('check out my website https://example.com');

            if (result.status == ShareResultStatus.success) {
                print('Thank you for sharing my website!');
            }
          }),
          SizedBox(height: 15,),
          MyButton(text: globalController.currentMapLanguage['contact us'], onClick: () {
            _launchURL('https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7');
          }),
          SizedBox(height: 70,),
          
        ],
      ),
    )));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}