import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/Controller/songsProperties.dart';
import 'package:music_player/View/musicView.dart';
import 'package:music_player/View/playlist.dart';
import 'package:music_player/Widget/topCard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'favoritePage.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //on Audio Query
  final OnAudioQuery _audioQuery = OnAudioQuery();
  //Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<SongModel>allSongs = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    requestPermission();
  }
  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
 void  requestPermission(){
   Permission.storage.request();
  }

  //Page View Controller
  late PageController _pageController;
  var selected_index ;
  int _currentIndex = 0;
  bool _unSelectedIndex = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF000633),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (indexPage) {
            setState(() {
              _currentIndex = indexPage;
            });
          },
          children: [
            Column(
              children: [
                TopCard(play: SizedBox(
                  width: 40,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicView(songModelList:allSongs,audioPlayer: _audioPlayer)));
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.play_arrow,color: Color(0xFF000633),),
                      ),
                    ),
                  ),
                )),
                Expanded(
                  child:
                  FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                        sortType: SongSortType.TITLE,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true,
                      ),
                      builder: (context, item) {
                        if (item.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (item.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No Songs Found!",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        // List<SongModel> songs=item.data!;
                        return
                          ListView.builder(
                            itemCount: item.data!.length,
                            itemBuilder: (context, index) {
                              allSongs.addAll(item.data!);
                              QueryArtworkWidget id = QueryArtworkWidget(
                                type: ArtworkType.AUDIO,
                                id: item.data![index].id,
                                artworkBorder: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),)
                              );
                              int index1 = index + 1;
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: ()  {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MusicView(songModelList: [item.data![index]],audioPlayer: _audioPlayer,SongThumb: id,)));
                                      },
                                      child:
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 15, right: 12, left: 15),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF30314D),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              index1.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    item.data![index].title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    item.data![index].artist ?? "No Artist", overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      SongsProperties.MusicName = item.data![index].title;
                                                      SongsProperties.SingerName = item.data![index].artist ??"No Artist";
                                                      SongsProperties.ThumbImage = id;
                                                      if (SongsProperties.Lottie==true) {
                                                        SongsProperties.Lottie = false;
                                                      }else{
                                                        SongsProperties.Lottie=true;
                                                      }
                                                      if (_unSelectedIndex==false) {
                                                        _unSelectedIndex=true;
                                                        selected_index=index;
                                                        print(selected_index);
                                                      }else{
                                                        _unSelectedIndex=false;
                                                        selected_index=index;
                                                        print(selected_index);
                                                      }
                                                    });
                                                    // await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(item.data![index].uri!)));
                                                    // await _audioPlayer.play();
                                                    print(SongsProperties.ThumbImage);
                                                  },
                                                  child: selected_index==index&&_unSelectedIndex?Icon(Icons.pause, size: 25, color: Color(0xFF000633),):Icon(Icons.play_arrow, size: 25, color: Color(0xFF000633),)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
            FavoritePage(),
            Playlist(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_note,
                  color: _currentIndex == 0 ? Colors.white : Colors.blueGrey,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                  color: _currentIndex == 1 ? Colors.white : Colors.blueGrey,
                ),
                label: 'Fav'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/playlist.png",
                  color: _currentIndex == 2 ? Colors.white : Colors.blueGrey,
                  width: size.width * .060,
                  height: size.height * .040,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
