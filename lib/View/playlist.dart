import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF000633),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Icon(
                          Icons.add_circle,
                          color: Color(0xFF000633),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
             
            ],
          )),
    );
  }
}
