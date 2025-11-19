import 'dart:io';

import 'package:bereal_clone/states/post_entries_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = Provider.of<PostEntriesState>(context).getPostEntries();
    return Scaffold(body: Center(child: images.isNotEmpty? Image.file(File(images[0].getBackImage().path)) : Text("Friends")));
  }
}
