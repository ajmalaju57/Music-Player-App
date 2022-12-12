import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Controller/songsProperties.dart';
import 'musicView.dart';

class ViewPlaylist extends StatefulWidget {
  const ViewPlaylist({Key? key}) : super(key: key);

  @override
  State<ViewPlaylist> createState() => _ViewPlaylistState();
}

class _ViewPlaylistState extends State<ViewPlaylist> {
  //on Audio Query
  final OnAudioQuery _audioQuery = OnAudioQuery();
  //Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<SongModel>allSongs = [];
  List<SongModel>playlist= [];

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  var selected_index ;
  int _currentIndex = 0;
  bool _unSelectedIndex = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF000633),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Icon(Icons.play_circle,color: Colors.white,size: 40,),
        actions: [
          InkWell(
              onTap: (){
                showModalBottomSheet(
                  backgroundColor: Color(0xFF000633),
                    context: context,
                    shape: const RoundedRectangleBorder( // <-- SEE HERE
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (context) {
                      return SizedBox(
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Expanded(
                              child: FutureBuilder<List<SongModel>>(
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
                                    return ListView.builder(
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
                                                                  playlist.add(item.data![index]);
                                                              });
                                                            },
                                                            child: Icon(Icons.add_circle,color:  Color(0xFF000633),)
                                                      )
                                                      )],
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
                      );
                    });
              },
              child: Icon(Icons.add,color: Colors.white,size: 40,))
        ],
      ),
      body: Column(
        children: [
      Expanded(
        child: ListView.builder(
        itemCount: playlist.length,
            itemBuilder: (context, index) {
              // allSongs.addAll(item.data!);
              // QueryArtworkWidget id = QueryArtworkWidget(
              //     type: ArtworkType.AUDIO,
              //     id: item.data![index].id,
              //     artworkBorder: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),)
              // );
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
                                builder: (context) => MusicView(songModelList: [playlist[index]],audioPlayer: _audioPlayer,)));
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
                                    playlist[index].title,
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
                                    playlist[index].artist ?? "No Artist", overflow: TextOverflow.ellipsis,
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
                                  onTap: ()  {
                                    setState(() {
                                      playlist.removeAt(index);
                                    });
                                  },
                                child: Icon(Icons.delete,color:Colors.red,),
                            )
                            )],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
        ],
      ),
    );
  }
}
