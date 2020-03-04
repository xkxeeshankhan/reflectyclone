import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reflectly/database/internet.dart';
import 'package:reflectly/database/story.dart';
import 'package:reflectly/model/storymodel.dart';
import 'package:reflectly/model/user.dart';
import 'package:reflectly/pages/addstory.dart';
import 'package:reflectly/pages/auth/signup.dart';
import 'package:reflectly/pages/auth/welcome.dart';
import 'package:reflectly/pages/subscription.dart';
import 'package:reflectly/res/colors.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/listofItems.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/widget/IconFromIcon.dart';
import 'package:reflectly/widget/IconFromImage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../showPopUp/bottomSheet.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.67);

  bool morning = true;
  bool evening = true;
  bool noInternetConnection = false;
  int _currentIndex = 0;
  List<StoryModel> stories;

  StoryDB storyDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storyDB = StoryDB();
    print("---init Home---");

    _getData();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print("--Connection Result $result----");
      if(result==ConnectivityResult.none){
        noInternetConnection = true;
      }else {
        noInternetConnection = false;
        storyDB.dispatch();
      }
    });
    morning = DateTime.now().hour >= 5 && DateTime.now().hour < 12;
    evening = DateTime.now().hour >= 12 && DateTime.now().hour <= 18;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 80,
          child: Container(
            color: greyColor,
          ),
        ),

//        Positioned(child: FadeInImage(placeholder: MemoryImage(kTransparentImage),  image:AssetImage(assetName))),

        Positioned(
          top: 100,
          left: -10,
          child: Image.asset(
            morning ? SUN_IMAGE : MOON_IMAGE,
            color: greyColor,
            width: 150,
            height: 150,
          ),
        ),

        Positioned(
          top: 0,
          bottom: 0,
          child: Container(
            color: Colors.white.withOpacity(0.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(
                        "${morning ? "Good Morning" : evening ? "Good Evening" : "Hi"},",
                        style: TextStyle(
                            color: lightGreyColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: FutureBuilder(
                        future: UserModel.getName(),
                        builder: (context, snapshot) => snapshot.hasData
                            ? Text(
                                snapshot?.data ?? "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: storyDB.stories,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error");
                          }

                          if (!snapshot.hasData) {
                            return shimmerWidget();
                          }

                          stories = snapshot.data;

                          if (stories.length == 0) {
                            return InkWell(
                              onTap: _addNewStory,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 600),
                                width: MediaQuery.of(context).size.width * 0.6,
                                margin: EdgeInsets.only(
                                    top: 10, bottom: 50, right: 30),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: endingColor,
                                          offset: Offset(0, 15),
                                          blurRadius: 25,
                                          spreadRadius: -20),
                                      BoxShadow(
                                          color: startingColor,
                                          offset: Offset(0, 20),
                                          blurRadius: 30,
                                          spreadRadius: -20)
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: [startingColor, endingColor],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft)),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: 65,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  right: 35,
                                                  child: Icon(
                                                    FontAwesomeIcons.plus,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 55,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Add Your First Story",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            onPageChanged: (index) {
                              _currentIndex = index;
                              setState(() {});
                            },
                            itemCount: stories.length,
                            itemBuilder: (context, index) {
                              return StoryItem(
                                storyModel: stories[index],
                                condition: _currentIndex == index,
                              );
                            },
                          );
                        })

//                  Container(
//                    color: Colors.blue,
//                    child: CarouselSlider.builder(
//                      onPageChanged: (index) {
//                        setState(() {
//                          _currentIndex = index;
//                        });
//                      },
//                      itemCount: images.length,
//                      itemBuilder: (context, index) {
//                        return StoryItem(imageUrl: images[index],);
//                      },
//                      reverse: false,
//                      enableInfiniteScroll: false,
//                      enlargeCenterPage: true,
//                      initialPage: _currentIndex,
//                      autoPlay: false,
//                      height: double.maxFinite,
//                      scrollDirection: Axis.horizontal,
////                      viewportFraction: 0.4,
////                      aspectRatio: ,
//                    ),
//                  ),
                    ),
              ],
            ),
          ),
        ),

        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 80,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              IconFromImage(
                imageUrl: SETTING_IMAGE,
                onClick: _subscriptionNavigator,
              ),
              SizedBox(
                height: 80,
              ),
              IconFromIcon(
                icon: Icons.add,
                onClick: _addNewStory,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shimmerWidget() {
    return Container(
      child: Text(noInternetConnection?"No Internet Connection" : "Loading..."),
    );
  }

  _addNewStory() {
    print("push");
    if(noInternetConnection) return;


    Route route = MaterialPageRoute(
      builder: (context) => AddStoryView(
        stories: stories ?? [],
      ),
    );
    Navigator.of(context).push(route).then((response) {
      storyDB.dispatch();

      if (response == "showSignUp" && signINUserID=="the_authenticated_user_id") {
        showSignUpSheet(context, onSuccess: () {
          storyDB.dispatch();
        });
      }
    });
  }

  _subscriptionNavigator() {
    Route route = MaterialPageRoute(
      builder: (context) => SubscriptionView(),
    );
    Navigator.of(context).push(route);
  }

  ///Server

  _getData() async{
    if(!(await Internet().checkConnection())){
      setState(() {
        noInternetConnection = true;
      });
      return;
    }

    storyDB.dispatch();
  }

}

class StoryItem extends StatelessWidget {
  final StoryModel storyModel;
  final bool condition;

  const StoryItem({Key key, this.storyModel, this.condition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double blur = condition ? 25 : 0;
    final double offset = condition ? 20 : 0;
    final double top = condition ? 10 : 40;
    Size size = MediaQuery.of(context).size;
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 40, right: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(storyModel.image),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, offset),
                  blurRadius: blur,
                  spreadRadius: -20)
            ]),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        DateFormat.d().format(storyModel.date),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.white.withOpacity(0.9),
                        size: 26,
                      )
                    ],
                  ),
                  Text(
                    DateFormat.MMM().format(storyModel.date),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Text(
                    DateFormat.y().format(storyModel.date),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          storyModel?.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: size.height * .04,
              right: -20,
              child: Icon(
                twoIconText[storyModel.overAllDay.floor()].icon,
                color: Colors.white.withOpacity(0.4),
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );

//      FadeInImage(
//        placeholder: MemoryImage(kTransparentImage),
//        fit: BoxFit.cover,
//        image: AssetImage(imageUrl));
  }
}
