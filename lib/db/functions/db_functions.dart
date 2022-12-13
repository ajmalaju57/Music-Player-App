import 'package:sqflite/sqflite.dart';

Future<void> initializationDatabase() async {
  openDatabase('music', version: 1, onCreate: (Database db, int version) {
    db.execute("");
    
  });
}

//favorite Song Storing Functions
Future<void> addFavSongs() async {}

Future<void> getFavSongs() async {}

Future<void> deleteFavSongs() async {}

//Playlist Data Storing Functions

Future<void> addPlayListSongs() async {}

Future<void> getPlayListongs() async {}

Future<void> updatePlayListName() async {}

Future<void> deletePlayList() async {}
