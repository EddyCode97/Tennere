import 'package:bereal_clone/screens/calendar_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.replay),
                      Icon(Icons.people_rounded),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  Icon(Icons.settings),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
