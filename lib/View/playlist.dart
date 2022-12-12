import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Controller/songsProperties.dart';
import 'package:music_player/View/viewPlaylist.dart';

import 'musicView.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  TextEditingController playlistName = TextEditingController();
  TextEditingController PlaylistEditName = TextEditingController();
  bool editFiled = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF000633),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.0),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 7,
                                color: Colors.grey)
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(
                                  Icons.folder_copy_outlined,
                                  color: Color(0xFF000633),
                                ),
                                onPressed: () {}),
                            Expanded(
                              child: TextField(
                                controller: playlistName,
                                decoration: InputDecoration(
                                    hintText: "New Playlist Name",
                                    hintStyle: TextStyle(
                                      color: Color(0xFF000633),
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 7,
                              color: Colors.grey)
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (playlistName.text.isNotEmpty) {
                                SongsProperties.PlaylistName.add(
                                    playlistName.text);
                                playlistName.text = "";
                              }
                            });
                          },
                          child: Icon(
                            Icons.add_circle,
                            color: Color(0xFF000633),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: SongsProperties.PlaylistName.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPlaylist()));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 15, right: 12, left: 15),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xFF30314D),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.folder_copy_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: editFiled?TextField(
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,
                                            fontSize: 17,),
                                          controller: PlaylistEditName,
                                        ):Text(
                                    SongsProperties.PlaylistName[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child:
                                        Text(
                                          "5 Songs",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 16,
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            if(editFiled==false){
                                              editFiled=true;
                                            }else{
                                              editFiled=false;
                                            }
                                            PlaylistEditName.text=SongsProperties.PlaylistName[index];
                                          });
                                        },
                                        child:editFiled?Icon(
                                          Icons.done,
                                          size: 25,
                                          color: Colors.green,
                                        ):Icon(
                                          Icons.edit,
                                          size: 25,
                                          color: Colors.green,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: InkWell(
                                        onTap: ()  {
                                          setState(() {
                                            SongsProperties.PlaylistName.removeAt(index);
                                          });
                                        },
                                        child: InkWell(
                                          child: Icon(
                                            Icons.delete,
                                            size: 25,
                                            color: Colors.red,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
