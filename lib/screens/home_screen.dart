import 'package:bereal_clone/camera.dart';
import 'package:flutter/material.dart';

enum Selected { myFriends, friendsOfFriends }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Selected selection = Selected.myFriends;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.notifications_rounded,
                    size: 28,
                    color: Colors.transparent,
                  ),
                  Text(
                    "BeReal.",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                  ),
                  Icon(Icons.notifications_rounded, size: 28),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selection = Selected.myFriends;
                    });
                  },
                  child: Text(
                    "My Friends",
                    style: TextStyle(
                      color: selection == Selected.myFriends
                          ? Colors.black
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selection = Selected.friendsOfFriends;
                    });
                  },
                  child: Text(
                    "Friends of Friends",
                    style: TextStyle(
                      color: selection == Selected.friendsOfFriends
                          ? Colors.black
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            selection == Selected.myFriends ? MyFriends() : FriendOfFriends(),
          ],
        ),
      ),
    );
  }
}

class MyFriends extends StatelessWidget {
  const MyFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Wow, it's really calm in here",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 2),
        Text("Your friends haven't posted their BeReal yet. Be "),
        Text("the first one."),
        SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            CameraApp.openCamera(context);
          },
          child: Ink(
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
              ),
            ),
            child: SizedBox(
              height: 40,
              width: 145,
              child: Center(child: Text("Take your BeReal.")),
            ),
          ),
        ),
      ],
    );
  }
}

class FriendOfFriends extends StatelessWidget {
  const FriendOfFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: ColoredBox(
              color: Colors.amber,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "DISCOVER THE",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "FRIENDS OF YOUR",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "FRIENDS",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {
                              CameraApp.openCamera(context);
                            },
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 15,
                              ),
                              child: Text(
                                "Post a BeReal.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
