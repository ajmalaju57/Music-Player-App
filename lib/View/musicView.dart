import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/Controller/songsProperties.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicView extends StatefulWidget {
  const MusicView({Key? key,this.songModelList,this.audioPlayer,this.SongThumb}) : super(key: key);
  final List<SongModel>? songModelList;
  final AudioPlayer? audioPlayer;
  final QueryArtworkWidget? SongThumb;

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  List<AudioSource>songList = [];
  int currentIndex = 0;
  bool _isFavoriteSongsIcon = false;
  int _isRepeatSongIcon =0;
  bool _isShuffle = false;
  @override
  void initState(){
      super.initState();
      playSong();
  }
  void playSong(){
      try {
        for(var element in widget.songModelList!){
          songList.add(AudioSource.uri(Uri.parse(element.uri!),
            tag: MediaItem(
              id: '${element.id}',
              album: "${element.album}",
              title:element.title,
              artUri: Uri.parse('https://example.com/albumart.jpg'),
            ),
          ));
        }
        widget.audioPlayer!.setAudioSource(
           ConcatenatingAudioSource(children: songList),
        );
        widget.audioPlayer!.play();
        SongsProperties.isPlaying = true;
        listenToSongIndex();
      } on Exception catch (e) {
        log("Cannot Pares song");
      }
      widget.audioPlayer!.durationStream.listen((d) {
        setState(() {
          _duration = d!;
        });
      });
      widget.audioPlayer!.positionStream.listen((p) {
        setState(() {
          _position = p;
        });
      });
  }
  void changeToSeconds(int seconds){
    Duration duration =Duration(seconds: seconds);
    widget.audioPlayer!.seek(duration);
  }
  void listenToSongIndex(){
    widget.audioPlayer!.currentIndexStream.listen((event) {
      setState(() {
        if(event != null){
          currentIndex=event;
          SongsProperties.isPlaying=true;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage("assets/images/music.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF000633).withOpacity(0.3),
                Color(0xFF000633).withOpacity(0.5),
                Color(0xFF000633).withOpacity(1),
                Color(0xFF000633).withOpacity(1),
              ]
            )
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(padding:EdgeInsets.symmetric(vertical: 45,horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(CupertinoIcons.back,color: Colors.white,),
                        )
                    ],
                  ),

                ),
                Spacer(),
                Container(
                  // color: Colors.white,
                  height: 290,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Padding(padding: EdgeInsets.symmetric(vertical: 21,horizontal: 19),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                   width:270,
                                    child:
                                    Text(widget.songModelList![currentIndex].title,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 24,fontWeight: FontWeight.bold),)),
                                SizedBox(height: 10,),
                                SizedBox(
                                    width:270,
                                    child: Text(widget.songModelList![currentIndex].artist??"No Artist",overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 18),)),
                              ],
                            ),
                          ),  
                          InkWell(
                            onTap: (){
                              setState(() {
                                if (_isFavoriteSongsIcon==false) {
                                  _isFavoriteSongsIcon = true;
                                }else{
                                  _isFavoriteSongsIcon = false;
                                }
                                SongsProperties.FaveSongMusicName.add(widget.songModelList![currentIndex].title);
                                SongsProperties.FaveSongSingerName.add(widget.songModelList![currentIndex].artist??"No Artist");
                              });
                            },
                            child: Container(

                                child:_isFavoriteSongsIcon?Icon(Icons.favorite,color:Colors.green,size: 35,):Icon(Icons.favorite_outline,color:Colors.white,size: 35,)),
                          ),
                        ],
                      ),
                      ),
                      Column(
                        children: [
                          Slider(
                          value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble(),
                            min: const Duration(microseconds: 0).inSeconds.toDouble(),
                            onChanged: (value){
                            setState(() {
                              changeToSeconds(value.toInt());
                              value = value;
                            });
                            },
                            activeColor:  Colors.white,
                            inactiveColor: Colors.white54,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(_position.toString().split(".")[0],style:TextStyle(color: Colors.white.withOpacity(0.6),fontWeight: FontWeight.w500,fontSize: 16),),
                                  Text(_duration.toString().split(".")[0],style:TextStyle(color: Colors.white.withOpacity(0.6),fontWeight: FontWeight.w500,fontSize: 16),)
                              ],
                            ),
                          )
                        ],
                      ),
                     SizedBox(height: 20,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: (){
                                setState(() {
                                  if (_isShuffle==false) {
                                    _isShuffle = true;
                                  }else{
                                    _isShuffle = false;
                                  }
                                });
                              },
                              child: Container(child: Icon(CupertinoIcons.shuffle,color:_isShuffle? Colors.green:Colors.white,size: 30,))),
                          InkWell(
                              onTap: (){
                                if(widget.audioPlayer!.hasPrevious){
                                  widget.audioPlayer!.seekToPrevious();
                                }
                              },
                              child: Icon(CupertinoIcons.backward_end_fill,color: Colors.white,size: 30,)),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(SongsProperties.isPlaying){
                                  widget.audioPlayer!.pause();
                                }else{
                                  widget.audioPlayer!.play();
                                }
                                SongsProperties.isPlaying = !SongsProperties.isPlaying;
                              });
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child:SongsProperties.isPlaying?Icon(Icons.pause,color:Color(0xFF000633),size: 45,):Icon(Icons.play_arrow,color:Color(0xFF000633),size: 45,),
                            ),
                          ),
                          InkWell(
                              onTap: (){
                                if(widget.audioPlayer!.hasNext){
                                  widget.audioPlayer!.seekToNext();
                                }

                              },
                              child: Icon(CupertinoIcons.forward_end_fill,color: Colors.white,size: 30,)),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  if (_isRepeatSongIcon==0) {
                                    _isRepeatSongIcon = 1;
                                  }else if(_isRepeatSongIcon==1){
                                    _isRepeatSongIcon = 2;
                                  }else{
                                    _isRepeatSongIcon=0;
                                  }
                                });
                              },
                              child: _isRepeatSongIcon==0?Icon(CupertinoIcons.repeat,color:Colors.white,size: 30,):_isRepeatSongIcon==1?Icon(CupertinoIcons.repeat,color:Colors.green,size: 30,):Icon(CupertinoIcons.repeat_1,color:Colors.green,size: 30,)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
