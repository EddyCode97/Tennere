import 'package:bereal_clone/states/post_entry.dart';
import 'package:flutter/material.dart';

class PostEntriesState extends ChangeNotifier {
  final List<PostEntry> _postEntries = [];

  void addPostEntry(PostEntry i) {
    _postEntries.add(i);
  }

  List<PostEntry> getImageEntries() {
    return _postEntries;
  }
}