import 'dart:io';

import 'package:bereal_clone/states/post_entries_state.dart';
import 'package:bereal_clone/states/post_entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthView extends StatelessWidget {
  final DateTime month;

  const MonthView({super.key, required this.month});

  List<DateTime> getDaysInMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final next = DateTime(month.year, month.month + 1, 1);
    List<DateTime> days = [];

    for (int i = 0; i < next.difference(first).inDays; i++) {
      days.add(DateTime(month.year, month.month, 1 + i));
    }

    return days;
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final days = getDaysInMonth(month);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            "${getMonth(month.month)} ${month.year}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            return DayTile(day: days[index]);
          },
        ),
      ],
    );
  }
}

class DayTile extends StatelessWidget {
  final DateTime day;

  DayTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final bool isToday =  (
      DateTime.now().day == day.day &&
      DateTime.now().month == day.month &&
      DateTime.now().year == day.year
    );
    final postProvider = context.watch<PostEntriesState>();

    List<PostEntry> posts = postProvider.getPostEntries();
    final matches = posts.where((p) =>
      p.getDateTime().year == day.year &&
      p.getDateTime().month == day.month &&
      p.getDateTime().day == day.day,
    );

    PostEntry? post = matches.isNotEmpty? matches.first : null;

    if (post != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(post.getBackImage().path),
              fit: BoxFit.cover,
            ),
          ),
          Text("${day.day}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
        ],
      );
    }

    return Center(
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: isToday? Colors.white : Colors.transparent,
          shape: BoxShape.circle
        ),
        child: Center(
          child: Text("${day.day}", style: TextStyle(color: isToday? Colors.black : Colors.white, fontWeight: FontWeight.w600))
        ),
      ),
    );
  }
}
