import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime today = DateTime.now();

  _onDaySelected(day, focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: TableCalendar(
        onHeaderTapped: ((focusedDay) => setState(() {
              print(focusedDay);
              today = focusedDay;
            })),
        locale: "id",
        headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
        availableGestures: AvailableGestures.all,
        focusedDay: today,
        firstDay: DateTime.utc(2010, 01, 01),
        lastDay: DateTime.utc(2030, 12, 30),
        // selectedDayPredicate: ((day) {
        //   print(day);
        //   // _onDaySelected(day, today);
        //   return isSameDay(day, today);
        // }),
      ),
    );
  }
}
