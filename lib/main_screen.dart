import 'package:bereal_clone/camera.dart';
import 'package:bereal_clone/screens/home_screen.dart';
import 'package:bereal_clone/screens/chat_screen.dart';
import 'package:bereal_clone/screens/friends_screen.dart';
import 'package:bereal_clone/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    FriendsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[100],
      body: screens[_selectedIndex],
      floatingActionButton: SizedBox(
        width: 72,
        height: 72,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            CameraApp.openCamera(context);
          },
          elevation: 6,
          shape: const CircleBorder(),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const SizedBox(
              width: 72,
              height: 72,
              child: Icon(
                Icons.camera_alt_rounded,
                size: 34,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Color(0xFF003366),
        elevation: 6,
        shadowColor: Colors.black.withAlpha(76),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => _onItemTapped(0),
                icon: Column(
                  children: [
                    Icon(
                      Icons.home,
                      size: 26,
                      color: _selectedIndex == 0
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: _selectedIndex == 0
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _onItemTapped(1),
                icon: Column(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      size: 26,
                      color: _selectedIndex == 1
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Friends",
                      style: TextStyle(
                        color: _selectedIndex == 1
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              IconButton(
                onPressed: () => _onItemTapped(2),
                icon: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outlined,
                      size: 26,
                      color: _selectedIndex == 2
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(
                        color: _selectedIndex == 2
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _onItemTapped(3),
                icon: Column(
                  children: [
                    Icon(
                      Icons.person_pin_circle_rounded,
                      size: 26,
                      color: _selectedIndex == 3
                          ? Colors.white
                          : Colors.white38,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: _selectedIndex == 3
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
