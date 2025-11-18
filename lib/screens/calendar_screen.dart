import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  late PageController _monthPageController;

  @override
  void initState() {
    super.initState();
    _monthPageController = PageController(initialPage: selectedDate.month - 1);
  }

  @override
  void dispose() {
    _monthPageController.dispose();
    super.dispose();
  }

  List<DateTime> getDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final days = <DateTime>[];

    final weekdayOfFirst = firstDay.weekday % 7;
    for (int i = 0; i < weekdayOfFirst; i++) {
      days.add(firstDay.subtract(Duration(days: weekdayOfFirst - i)));
    }

    for (int i = 0; i < lastDay.day; i++) {
      days.add(DateTime(date.year, date.month, i + 1));
    }

    return days;
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final year = DateTime.now().year - 2 + index;
                final isSelected = year == selectedDate.year;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = DateTime(
                        year,
                        selectedDate.month,
                        selectedDate.day,
                      );
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 50,
            child: PageView.builder(
              controller: _monthPageController,
              onPageChanged: (index) {
                setState(() {
                  selectedDate = DateTime(selectedDate.year, index + 1, 1);
                });
              },
              itemCount: 12,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    getMonthName(index + 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map(
                    (day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.8,
                ),
                itemCount: getDaysInMonth(selectedDate).length,
                itemBuilder: (context, index) {
                  final day = getDaysInMonth(selectedDate)[index];
                  final isCurrentMonth = day.month == selectedDate.month;
                  final isToday =
                      day.day == DateTime.now().day &&
                      day.month == DateTime.now().month &&
                      day.year == DateTime.now().year;

                  final hasMemory = isCurrentMonth && day.day % 3 == 0;

                  return GestureDetector(
                    onTap: isCurrentMonth
                        ? () {
                            setState(() {
                              selectedDate = day;
                            });
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: isToday
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            style: TextStyle(
                              color: isCurrentMonth
                                  ? Colors.white
                                  : Colors.grey.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (hasMemory)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
