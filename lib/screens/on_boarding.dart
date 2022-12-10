
import 'package:flutter/material.dart';
import 'package:hacthon2/core/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../component/Components.dart';
import '../network/cache_helper.dart';
import 'home_screen.dart';

class BoardingModel{
  late final String image ;
  late final String title ;
  late final String body ;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List <BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/image2.png',
      title: 'scan and find case ',
      body: 'Create a profile for people with special needs . ',
    ),
    BoardingModel(
      image: 'assets/images/image1.png',
      title: ' sign language Convertor',
      body: 'Converting sign language into speech and vice versa for easy communication .',
    ),
    BoardingModel(
      image: 'assets/images/image3.png',
      title: 'Ease of communication',
      body: 'Ease of communication between all people with special needs and each other',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigationAndFinish(context,HomeScreen(),);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const  BouncingScrollPhysics(),
                controller:boardController ,
                itemBuilder:(context,index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index){
                  if(index == boarding.length -1) {
                    setState(() {
                      isLast = true ;
                    });
                  }else{
                    setState(() {
                      isLast = false ;
                    });
                  }
                },
              ),
            ),
           const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                onPressed: (){
                 submit();
                },
                  child:const Text(
                 'Skip',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                 ),
                ),
                SmoothPageIndicator(
                  controller:boardController ,
                  count:boarding.length,
                  effect:const ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: yellowColor,
                    dotHeight: 5,
                    dotWidth: 5,
                    expansionFactor: 3,
                    spacing: 10,
                  ),
                ),
                MaterialButton(
                  height: 30,
                    minWidth: 30,
                    color: yellowColor,
                    onPressed: (){
                  if( isLast){
                     submit();
                  } else{
                    boardController.nextPage(
                      duration:const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                  child:const Text('Next',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: Image(image:AssetImage(model.image))),
     const SizedBox(
        height: 20.0,
      ),
      Text(model.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
     const SizedBox(
        height: 10.0,
      ),
      Text(model.body,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    ],
  );
}
