import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/Controller/songsProperties.dart';

class TopCard extends StatefulWidget {
  final Widget play;
   TopCard({Key? key,required this.play}) : super(key: key);

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
              height: size.height*.33,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(51,1,57,1),
                  image: DecorationImage(
                        image:ExactAssetImage("assets/images/thum.png",),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),)
              ),
          child:SongsProperties.ThumbImage,
            ),
        Container(margin: EdgeInsets.symmetric(horizontal: 120),
          width: 140,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14),bottomRight:Radius.circular(14))
          ),
          child: Lottie.asset("assets/lotties/barsmusic.json",
            fit: BoxFit.fill,animate:SongsProperties.Lottie)
        ),
        Padding(
          padding:  EdgeInsets.only(top: size.height*.261,left: size.width*.050),
          child: Text(SongsProperties.MusicName!,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        ),
        Padding(
          padding:  EdgeInsets.only(top: size.height*.295,left: size.width*.050),
          child: Text(SongsProperties.SingerName!,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white38,fontWeight: FontWeight.bold,fontSize: 15),),
        ),
        Padding(
            padding:  EdgeInsets.only(top: size.height*.236,left:size.width*.789),
            child: BlurryContainer(
                color: Colors.white.withOpacity(0.15),
                blur: 30,
                elevation: 6,
                height: size.height*.074,
                child: widget.play,
            )
        ),
      ],
    );
  }
}
