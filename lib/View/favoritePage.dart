import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Controller/songsProperties.dart';

import 'musicView.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color(0xFF000633),
        // backgroundColor: Color.fromRGBO(181, 194, 247, 1),
        body: Container(
          child: ListView.builder(
              itemCount: SongsProperties.FaveSongSingerName.length,
              itemBuilder: (context,index) {
                int index1 = index+1;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>MusicView()));
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
                                    child: Text(SongsProperties.FaveSongMusicName[index], overflow:
                                    TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child: Text(SongsProperties.FaveSongSingerName[index],overflow:
                                          TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),)),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    SongsProperties.FaveSongMusicName.removeAt(index);
                                    SongsProperties.FaveSongSingerName.removeAt(index);
                                    print(SongsProperties.FaveSongMusicName);
                                  });
                                },
                                  child: Icon(Icons.favorite,color: Colors.green,)),
                              SizedBox(width: 10,),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                    onTap: (){
                                      // setState((){
                                      //   selected_index = index;
                                      //   print(selected_index);
                                      // });
                                    },
                                    child: Icon(Icons.play_arrow,size: 25,color: Color(0xFF000633),)),
                              ),
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
      ),
    );
  }
}
