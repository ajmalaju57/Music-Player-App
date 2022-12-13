import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/Controller/songsProperties.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'musicView.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  //on Audio Query
  final OnAudioQuery _audioQuery = OnAudioQuery();
  //Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<SongModel>allSongs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color(0xFF000633),
        // backgroundColor: Color.fromRGBO(181, 194, 247, 1),
        body: Container(
          child: ListView.builder(
              itemCount: SongsProperties.FavoriteSongs.length,
              itemBuilder: (context,index) {
                allSongs.addAll(SongsProperties.FavoriteSongs);
                int index1 = index+1;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicView(songModelList: [SongsProperties.FavoriteSongs[index]],audioPlayer: _audioPlayer,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15,right: 12,left: 15),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFF30314D),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(index1.toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                              SizedBox(width: 25,),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(SongsProperties.FavoriteSongs[index].title, overflow:
                                    TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child: Text(SongsProperties.FavoriteSongs[index].artist ?? "No Artist",overflow:
                                          TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),)),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    SongsProperties.FavoriteSongs.removeAt(index);
                                  });
                                },
                                  child: Icon(Icons.favorite,color: Colors.green,)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );

              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MusicView(songModelList:allSongs,audioPlayer: _audioPlayer)));
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.play_circle,color:Colors.white,size: 50,),
           shape: BeveledRectangleBorder(
            borderRadius:BorderRadius.circular(200)
        ),
        ),
      ),
    );
  }
}
