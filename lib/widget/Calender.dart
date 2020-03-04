

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalender extends StatefulWidget {
  final CalendarController _controller;
  final Map<DateTime, List> _eventRecorded;
  final DateTime _selectedDate;

  CustomCalender(this._controller, this._eventRecorded, this._selectedDate);

  @override
  _CustomCalenderState createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  Color startingColor = Color(0xffFF747A);
  Color endingColor = Color(0xffF566A2);

  List _startingDayOfMonth = [
    StartingDayOfWeek.monday,
    StartingDayOfWeek.tuesday,
    StartingDayOfWeek.wednesday,
    StartingDayOfWeek.thursday,
    StartingDayOfWeek.friday,
    StartingDayOfWeek.saturday,
    StartingDayOfWeek.sunday,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Event Recorded Lentht ${widget._eventRecorded.length}");
    widget._eventRecorded.forEach((key, value) {
      print("$key ${value.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.0),
        body: Padding(
          padding: EdgeInsets.only(
              top: size.height * .18,
              left: size.width * .05,
              right: size.width * .05),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: EdgeInsets.only(top: 50, bottom: 10),
                  child: TableCalendar(
                    calendarController: widget._controller,
                    onVisibleDaysChanged: (datetime, dateTime2, format) {
                      print("On Visible Day Changed");
                    },
                    onDaySelected: (dateTime, eventList) {
                      print("Date Selected $dateTime ${eventList.length}");
                      if (eventList.length == 0) {
                        Navigator.of(context).pop();
                      } else {}
                    },
                    enabledDayPredicate: (date) {
                      bool value = true;
                      widget._eventRecorded.forEach((key, val) {
                        if (key.toString().substring(0, 10) ==
                            date.toString().substring(0, 10)) value = false;
                      });

                      return value;
                    },
                    headerVisible: false,

                    initialSelectedDay: widget._selectedDate,

                    availableGestures: AvailableGestures.horizontalSwipe,

                    daysOfWeekStyle: DaysOfWeekStyle(
                      ///Mon - Sun
                      weekdayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                    calendarStyle: CalendarStyle(
                      ///Numbers 1-31
                      weekdayStyle:
                      TextStyle(color: Colors.black, fontSize: 16),
                      weekendStyle:
                      TextStyle(color: Colors.black, fontSize: 16),
                      holidayStyle: TextStyle(color: Colors.grey),
                      outsideHolidayStyle: TextStyle(color: Colors.black),
                      outsideStyle: TextStyle(color: Colors.black),
                      outsideWeekendStyle: TextStyle(color: Colors.black),
                      markersColor: startingColor,
                      highlightToday: true,
                      highlightSelected: true,
                      renderDaysOfWeek: false,

                      todayColor: endingColor.withOpacity(0.4),
                      selectedColor: endingColor,

//                outsideHolidayStyle: TextStyle(color: Colors.black),
                    ),

                    ///not required
                    headerStyle: HeaderStyle(),

                    endDay: DateTime.now(),
                    holidays: widget._eventRecorded,
                    events: widget._eventRecorded,

                    startingDayOfWeek: _startingDayOfMonth[DateTime.utc(
                        widget._controller?.selectedDay?.year ??
                            DateTime.now().year,
                        widget._controller?.selectedDay?.month ??
                            DateTime.now().month,
                        1)
                        .weekday -
                        1],
                  ),
                ),
              ),
              Positioned(
                  left: 15,
                  right: 15,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        gradient: LinearGradient(
                          colors: [endingColor, startingColor],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                DateTime selected =
                                    widget._controller?.selectedDay ??
                                        DateTime.now();
                                widget._controller.setSelectedDay(DateTime.utc(
                                    selected.year, selected.month - 1, 1));
                                setState(() {});
                              }),
                        ),
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  DateFormat.MMMM().format(
                                      widget._controller?.selectedDay ??
                                          DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat.y().format(
                                      widget._controller?.selectedDay ??
                                          DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                ),
                                color: Colors.white,
                                disabledColor: Colors.white.withOpacity(0.4),
                                onPressed: widget._controller.selectedDay !=
                                    null &&
                                    widget._controller.selectedDay
                                        .toString()
                                        .substring(0, 10) ==
                                        DateTime.now()
                                            .toString()
                                            .substring(0, 10)
                                    ? null
                                    : () {
                                  DateTime selected =
                                      widget._controller?.selectedDay ??
                                          DateTime.now();
                                  widget._controller.setSelectedDay(
                                      DateTime.utc(selected.year,
                                          selected.month + 1, 1));
                                  setState(() {});
                                })),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
