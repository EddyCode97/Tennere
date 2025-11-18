import 'package:camera/camera.dart';

class PostEntry {
  final XFile _backImage;
  final XFile _frontImage;

  final DateTime _dateTime;

  PostEntry(this._backImage, this._frontImage, this._dateTime);

  XFile getBackImage() { return _backImage; }
  XFile getFrontImage() { return _frontImage; }
  DateTime getDateTime() { return _dateTime; }
}