import 'package:bereal_clone/widgets/month_view.dart';
import 'package:flutter/material.dart';

DateTime onlyDate(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<DateTime> months = [];

  DateTime start = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    for(int i = 1; i >= 0; i--) {
      months.add(DateTime(start.year, start.month - i));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<PostEntriesState>();
    // DateTime dayDate = DateTime.now();
    // PostEntry? postForThisDay;

    // for (var p in provider.getPostEntries()) {
    //   if (onlyDate(p.getDateTime()) == onlyDate(dayDate)) {
    //     postForThisDay = p;
    //     break;
    //   }
    // }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Memories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          return MonthView(month: months[index]);
        },
      ),
    );
  }
}