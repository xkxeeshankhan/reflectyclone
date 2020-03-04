import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reflectly/animation/circular_reveal_animation.dart';
import 'package:reflectly/model/color.dart';
import 'package:reflectly/model/user.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/widget/InputTextFieldTitle.dart';

import '../../dashboard.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  PageController _pageController = PageController();
  PageController _pageControllerSlider =
      PageController(initialPage: 0, viewportFraction: 0.32);
  int currentPageIndex = 0;
  int _fourCurrentIndex = 0;
  int _fourPreviousIndex = 0;

  TextEditingController _whatShallICallYouController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.addListener(() {
      print("Animatd ${animationController.status}");
      if (animationController.status == AnimationStatus.completed) {
//        setState(() {});
      }
    });
    _whatShallICallYouController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _previousGradientColor(),
          _gradientColor(),
          _contentBuilder(),
          _topRightClose(),
          _emoji(),
          _bottomRightArrow(),
        ],
      ),
    );
  }

  Widget _emoji() {
    Size size = MediaQuery.of(context).size;
    bool condition = false;
    return AnimatedContainer(
      height: condition ? 95 : 70,
      width: condition ? size.width : 70,
      alignment: Alignment.bottomCenter,
      margin:
          EdgeInsets.only(top: condition ? 100 : 50, left: condition ? 0 : 25),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: condition ? 75 : 60,
              width: condition ? 75 : 60,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, condition ? 20 : 10)),
              ]),
            ),
          ),
          Center(child: Image.asset(REFLECTLY_GIF)),
        ],
      ),
      duration: Duration(milliseconds: 500),
    );
  }

  Widget _previousGradientColor() {
    Size size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      curve: Curves.easeInCirc,
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            colorsList[_fourPreviousIndex].startingColor,
            colorsList[_fourPreviousIndex].endingColor
          ])),
    );
  }

  Widget _gradientColor() {
    Size size = MediaQuery.of(context).size;

    return CircularRevealAnimation(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorsList[_fourCurrentIndex].startingColor,
              colorsList[_fourCurrentIndex].endingColor
            ],
          ),
        ),
      ),
      animation: animation,
      centerAlignment: Alignment.center,
//      centerOffset: Offset(130, 100),
//                minRadius: 12,
//                maxRadius: 200,
    );

//    return AnimatedContainer(
//      duration: Duration(milliseconds: 400),
//      curve: Curves.easeInCirc,
//      width: size.width,
//      height: size.height,
//      decoration: BoxDecoration(
//          gradient: LinearGradient(
//              begin: Alignment.topRight,
//              end: Alignment.bottomLeft,
//              colors: [
//            colorsList[_fourCurrentIndex].startingColor,
//            colorsList[_fourCurrentIndex].endingColor
//          ])),
//    );
  }

  Widget _topRightClose() {
    return Positioned(
      right: 20,
      top: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [0, 1].map((index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Icon(
              Icons.brightness_1,
              size: 12,
              color: currentPageIndex == index
                  ? Colors.white
                  : Colors.black.withOpacity(0.2),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _contentBuilder() {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      onPageChanged: (pageIndex) {
        print("PageIndex $pageIndex");
        setState(() {
          currentPageIndex = pageIndex;
        });
      },
      physics: NeverScrollableScrollPhysics(),
      pageSnapping: true,
      reverse: false,
      children: <Widget>[
        _onePage(),
        _twoPage(),
      ],
    );
  }

  Widget _bottomRightArrow() {
    return MediaQuery.of(context).viewInsets.bottom != 0
        ? Container()
        : Positioned(
            right: 20,
            bottom: 10,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: _previousPage,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 45,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                currentPageIndex == 1
                    ? Container()
                    : InkWell(
                        onTap: _nextPage,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 45,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      )
              ],
            ));
  }

  Widget _onePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Text(
            "Nice to meet you! What do your friends call you?",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: InputTextFieldTitle(
              controller: _whatShallICallYouController,
              title: "They Call me",
              bottomText: "your nickname",
            ),
          ),
          MediaQuery.of(context).viewInsets.bottom != 0
              ? Container()
              : SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _twoPage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: <Widget>[
              Text(
                "Themes, ${_whatShallICallYouController?.text ?? ""}! Which one is most you?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Can be changed letter in the settings".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.2),
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: Center(
          child: Container(
            height: 150,
            padding: EdgeInsets.only(left: 20),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageControllerSlider,
              onPageChanged: (index) {
                print("Change");
                _fourPreviousIndex = _fourCurrentIndex;
                _fourCurrentIndex = index;
setState(() {

});
//                animationController.reverse();
                animationController.forward(from: 0);
//                animationController.repeat(min: 1,max: 1);
//                animationController.reset();
//                animationController.repeat(min: 0,max: 1);
//                animationController.repeat();
              },
              itemCount: colorsList.length,
              itemBuilder: (context, index) {
                return _colorWidget(index);
              },
            ),
          ),
        )

//          CarouselSlider.builder(
//            onPageChanged: (index) {
//              setState(() {
//                _fourCurrentIndex = index;
//              });
//            },
//            itemCount: colorsList.length,
//            itemBuilder: (context, index) {
//              return _colorWidget(index);
//            },
//            reverse: false,
//            enableInfiniteScroll: false,
//            enlargeCenterPage: true,
//            initialPage: _fourCurrentIndex,
//            autoPlay: false,
//            scrollDirection: Axis.horizontal,
//            viewportFraction: 0.32,
//          ),
            ),
        MediaQuery.of(context).viewInsets.bottom != 0
            ? Container()
            : SizedBox(
                height: 100,
                width: double.maxFinite,
                child: Center(
                  child: InkWell(
                    onTap: _doneClicked,
                    child: Text(
                      "Done".toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _colorWidget(int index) {
//    print("Index $index Current $_fourCurrentIndex top $top bottom $bottom");

    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          top: index == _fourCurrentIndex
              ? 0
              : index > _fourCurrentIndex ? 0 : null,
          bottom: index == _fourCurrentIndex
              ? 0
              : index < _fourCurrentIndex ? 0 : null,
          duration: Duration(milliseconds: 800),
          child: Center(
            child: InkWell(
              onTap: () {
                print("On Lick $index");
                _pageControllerSlider.animateToPage(index,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.linear);
              },
              child: AnimatedContainer(
                width: index == _fourCurrentIndex ? 80 : 60,
                height: index == _fourCurrentIndex ? 80 : 60,
                duration: Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white, width: 3.0),
                  gradient: LinearGradient(
                    colors: [
                      colorsList[index].startingColor,
                      colorsList[index].endingColor,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Center(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _nextPage() {
    if (currentPageIndex == 0 &&
        _whatShallICallYouController.text.length == 0) {
      return;
    }
    _pageController.animateToPage(currentPageIndex + 1,
        duration: Duration(milliseconds: 800), curve: Curves.linear);
  }

  _previousPage() {
    _pageController.animateToPage(currentPageIndex - 1,
        duration: Duration(milliseconds: 600), curve: Curves.linear);
  }

  _doneClicked() async {
    ///user id is set to the global signinuserid value
    await UserModel(name: _whatShallICallYouController.text, uid: signINUserID)
        .saveUpdatePrefs();

    await ColorModel.withParams(
            colorsList[_fourCurrentIndex].startingColor.value,
            colorsList[_fourCurrentIndex].endingColor.value)
        .saveInPrefs();

    Navigator.of(context).popUntil((route) => route.isFirst);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DashboardView(),
    ));
  }
}
