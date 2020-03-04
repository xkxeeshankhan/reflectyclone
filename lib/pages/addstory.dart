import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reflectly/database/image.dart';
import 'package:reflectly/database/internet.dart';
import 'package:reflectly/database/question.dart';
import 'package:reflectly/dialog/cancel.dart';
import 'package:reflectly/model/questionmodel.dart';
import 'package:reflectly/model/storymodel.dart';
import 'package:reflectly/model/user.dart';
import 'package:reflectly/pages/showPopUp/internetpopup.dart';
import 'package:reflectly/res/global.dart';
import 'package:reflectly/res/listofItems.dart';
import 'package:reflectly/res/stringimage.dart';
import 'package:reflectly/widget/Calender.dart';
import 'package:reflectly/widget/InputTextFieldTitle.dart';
import 'package:reflectly/widget/button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

import 'package:reflectly/res/colors.dart';
import 'package:intl/intl.dart';

class AddStoryView extends StatefulWidget {
  final List<StoryModel> stories;

  const AddStoryView({Key key, this.stories}) : super(key: key);

  @override
  _AddStoryViewState createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  PageController _pageController = PageController();

  int currentPageIndex = 0;
  int _fourCurrentIndex = 0;
  double sliderValue = 2;

  TextEditingController _questionOfDayController;
  TextEditingController _titleController;
  CalendarController _controller;

  bool showAnswerField = false;

  Map<DateTime, List> _eventRecorded;

  DateTime _selectedDate;

  bool loadingPreData = true;
  bool loading = false;
  String imageURL;

  QuestionModel questionModel;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();

    _controllerSetDate(DateTime.now().toString().substring(0, 10));

    _eventRecorded = {};
    widget.stories.forEach((story) {
      _eventRecorded.addAll({
        story.date: ["story Found"]
      });
    });
    _questionOfDayController = TextEditingController();
    _titleController = TextEditingController();
    _resetLists();
    String length = (widget.stories.length + 1).toString();

    _getImageUrlForThisStory(length);

    _getQuestionForThisStory();

    setState(() {});
  }

  _getImageUrlForThisStory(String length) async {
    imageURL = await ImageDB(length).imageURL;
    if (imageURL != null) {
      setState(() {
        loadingPreData = false;
      });
    } else {
      _getNumberBetweenZeroToSix();
    }
  }

  _getNumberBetweenZeroToSix() {
    int number = widget.stories.length + 1;
    while (number > 6) {
      number -= 6;
    }
    _getImageUrlForThisStory(number.toString());
  }

  _getQuestionForThisStory() async {
    QuestionDB questionDB = QuestionDB();
    questionModel = await questionDB.randomQuestion;
    questionDB.dispose();
    print(questionModel.questionText);
    setState(() {});
  }

  _controllerSetDate(String date) {
    print(date);

    if (widget.stories
            .where((story) => story.date.toString().substring(0, 10) == date)
            .toList()
            .length >
        0) {
      _controllerSetDate(DateTime.parse(date)
          .add(Duration(days: -1))
          .toString()
          .substring(0, 10));
    } else {
      _selectedDate = DateTime.parse(date);

//      try {
//      }catch(e){
//        print(e);
//      }
    }
  }

  _resetLists() {
    twoIconText.forEach((item) {
      item.selected = false;
    });
    threeIconTexts.forEach((item) {
      item.selected = false;
    });
    fourIconTexts.forEach((item) {
      item.selected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _cancelDialog(popTwoTimes: false);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _gradientColor(),
            _contentBuilder(),
            _topRightClose(),
            _emoji(),
            _bottomRightArrow(),
          ],
        ),
      ),
    );
  }

  Widget _emoji() {
    Size size = MediaQuery.of(context).size;
    bool condition = currentPageIndex == 0 || currentPageIndex == 5;
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

  Widget _gradientColor() {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [startingColor, endingColor])),
    );
  }

  Widget _topRightClose() {
    return Positioned(
      right: 20,
      top: 50,
      child: InkWell(
        onTap: _cancelDialog,
        child: Icon(
          Icons.clear,
          size: 30,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _bottomRightArrow() {
    return currentPageIndex == 0 ||
            MediaQuery.of(context).viewInsets.bottom != 0 ||
            currentPageIndex == 5
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
                InkWell(
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
        _threePage(),
        _fourPage(),
        _fivePage(),
        _sixPage(),
      ],
    );
  }

  Widget _onePage() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 225,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder(
                future: UserModel.getName(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        "Good evening ${snapshot?.data ?? ""}, ready to create a new story?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      )
                    : Container(),
              )),
          Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 85,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Text(
                              "Story Date",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.1),
                                  fontSize: 65,
                                  letterSpacing: 3.0,
                                  fontWeight: FontWeight.w800),
                            )),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _showCalender,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    DateFormat.MMMMd().format(
                                        _controller?.selectedDay ??
                                            _selectedDate),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: Colors.white.withOpacity(0.5),
                                  )
                                ],
                              ),
                            ))
                      ],
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "today".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                )
              ],
            )),
          ),
          RoundedButton(
            width: .8,
            loading: loadingPreData,
            onPressed: loadingPreData ? null : _nextPage,
            text: "let's do it!",
            color: endingColor,
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _twoPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Row(
              children: <Widget>[
                Text(
                  "How was your day today?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: .8,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      twoIconText[sliderValue.floor()].icon,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTickMarkColor: Colors.white,
                        activeTrackColor: Colors.white,
                        trackHeight: 5,
                        thumbColor: Colors.white,
                        disabledActiveTickMarkColor:
                            Colors.black.withOpacity(0.7),
                        disabledActiveTrackColor: Colors.black.withOpacity(0.7),
                        disabledInactiveTickMarkColor: Colors.green,
                        disabledInactiveTrackColor: endingColor,
                        overlayColor: Colors.orange,
                        inactiveTickMarkColor: Colors.black.withOpacity(0.7),
                        disabledThumbColor: Colors.black.withOpacity(0.7),
                      ),
                      child: Slider(
                        value: sliderValue,
                        min: 0,
                        max: 4,
                        inactiveColor: Colors.black.withOpacity(0.2),
                        activeColor: Colors.white,
//divisions: 4,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value.floor().toDouble();
                          });

                          _nextPage();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "rate your day".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text(
                          twoIconText[sliderValue.floor()].text.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _threePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    "Great - what made today ${twoIconText[sliderValue.floor()].text}?",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.1),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: threeIconTexts
                    .map((item) => _stepThreeSubWidget(item))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepThreeSubWidget(IconText data) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 60,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(data.selected ? 0.2 : 0.0),
                  blurRadius: 6,
                  spreadRadius: 0,
                  offset: Offset(0, 25))
            ], shape: BoxShape.circle),
          ),
        ),
        InkWell(
          onTap: () {
            threeIconTexts.forEach((e) {
              e.selected = false;
            });
            data.selected = true;
            setState(() {});
            _nextPage();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: data.selected
                    ? Colors.white
                    : Colors.white.withOpacity(0.0)),
            margin: EdgeInsets.all(5.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    data.icon,
                    size: 35,
                    color: data.selected ? endingColor : Colors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(data.text,
                      style: TextStyle(
                          color: data.selected
                              ? endingColor
                              : Colors.white.withOpacity(0.7)))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fourPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    "How did you feel throughout the day?",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CarouselSlider.builder(
                onPageChanged: (index) {
                  setState(() {
                    _fourCurrentIndex = index;
                  });
                },
                itemCount: fourIconTexts.length,
                itemBuilder: (context, index) {
                  return _fourSubWidget(
                      fourIconTexts[index], _fourCurrentIndex == index);
                },
                reverse: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                initialPage: _fourCurrentIndex,
                height: 140,
                autoPlay: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.32,
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Widget _fourSubWidget(IconText iconText, bool isCurrentIndex) {
    return Column(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconText.icon,
          size: 50,
          color: isCurrentIndex ? Colors.white : Colors.white.withOpacity(0.7),
        ),
        SizedBox(
          height: 15,
        ),
        isCurrentIndex
            ? Text(iconText.text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: isCurrentIndex
                        ? Colors.white
                        : Colors.white.withOpacity(0.7)))
            : Container(),
      ],
    );
  }

  Widget _fivePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    questionModel?.questionText ?? "",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    "Question of the day".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.2),
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: showAnswerField
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.white.withOpacity(0.3)))),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                              controller: _questionOfDayController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              showCursor: true,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Hmm, well..",
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                        MediaQuery.of(context).viewInsets.bottom != 0
                            ? Container()
                            : SizedBox(height: 75),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RoundedButton(
                          width: .53,
                          onPressed: () {
                            setState(() {
                              showAnswerField = true;
                            });
                          },
                          text: "Well..",
                          color: endingColor,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: _nextPage,
                          child: Text(
                            "i don't know".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
            ),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _sixPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 225,
            ),
            Text(
              "Outstanding - another story locked in. What would be the good title for it?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w300),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InputTextFieldTitle(
                    controller: _titleController,
                    title: "Add title ...",
                    bottomText: "story title",
                  ),
//                  TextFormField(
//                    style: TextStyle(color: Colors.white, fontSize: 28.0),
//                    controller: _titleController,
//                    textAlign: TextAlign.left,
//                    keyboardType: TextInputType.text,
//                    showCursor: true,
//                    cursorColor: Colors.white,
//                    decoration: InputDecoration(
//                        border: InputBorder.none,
//                        hintText: "Add title ...",
//                        hintStyle: TextStyle(
//                            color: Colors.white.withOpacity(0.5),
//                            fontWeight: FontWeight.w300,
//                            fontSize: 28)),
//                  ),
                ],
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : Column(
                    children: <Widget>[
                      RoundedButton(
                          color: endingColor,
                          width: .8,
                          text: "Save story",
                          loading: loading,
                          onPressed: _submitStory),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: _previousPage,
                        child: Text(
                          "Wait, i forgot something".toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.4)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _moveToFirst() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 800), curve: Curves.linear);
  }

  _nextPage() {
    if (currentPageIndex == 2 &&
        threeIconTexts.where((data) => data.selected).toList().length <= 0) {
      return;
    }

    if (currentPageIndex + 1 == 5 || currentPageIndex + 1 == 1) {
      setState(() {
        currentPageIndex += 1;
      });
      _pageController.animateToPage(currentPageIndex,
          duration: Duration(milliseconds: 800), curve: Curves.linear);
    } else {
      _pageController.animateToPage(currentPageIndex + 1,
          duration: Duration(milliseconds: 800), curve: Curves.linear);
    }
  }

  _previousPage() {
    if (currentPageIndex - 1 == 0 || currentPageIndex - 1 == 4) {
      setState(() {
        currentPageIndex -= 1;
      });
      _pageController.animateToPage(currentPageIndex,
          duration: Duration(milliseconds: 800), curve: Curves.linear);
    } else {
      _pageController.animateToPage(currentPageIndex - 1,
          duration: Duration(milliseconds: 600), curve: Curves.linear);
    }
  }

  _showCalender() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomCalender(_controller, _eventRecorded,
              _controller?.selectedDay ?? _selectedDate);
        }).then((_) {
      print("Home DateTime ${_controller.selectedDay}");
      setState(() {});
    });
  }

  _submitStory() async {
    if (!(await Internet().checkConnection())) {
      showInternetDialog(context, retry: _submitStory);
      return;
    }

    setState(() {
      loading = true;
    });
    StoryModel story = StoryModel(
        title: _titleController.text,
        answer: _questionOfDayController.text,
        date: (_controller?.selectedDay ?? _selectedDate),
        feelWholeDay: _fourCurrentIndex,
        overAllDay: sliderValue,
        questionId: questionModel.id,
        image: imageURL,
        reason: threeIconTexts.where((data) => data.selected).first.text);

    ///If user has signup or sign storing user story to firebase
    ///else story in local db once user sign up the data will be fetch from [StoryModel] and send it to the server
    if (signINUserID != "the_authenticated_user_id") {
      CollectionReference storyCollection = Firestore.instance
          .collection("user")
          .document(signINUserID)
          .collection("story");

      storyCollection.document().setData(story.toJson()).then((_) {
        setState(() {
          loading = false;
        });
        _navigateBack();
      }).catchError((e) {
        print("Submit Story Error $e");
      });
    } else {
      await story.saveStoryInPref();
      _navigateBack();
    }
  }

  _navigateBack() {
    if (widget.stories.length == 0) {
      Navigator.of(context).pop("showSignUp");
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _cancelDialog({bool popTwoTimes = true}) async {
    return await showDialog(
            context: context,
            builder: (context) => CancelDialog(
                  popTwoTimes: popTwoTimes,
                )) ??
        false;
  }
}

class IconText {
  IconData icon;
  String text;
  bool selected;

  IconText(this.icon, this.text, {this.selected = false});
}
