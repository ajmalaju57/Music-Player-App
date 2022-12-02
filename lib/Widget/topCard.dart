import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/Controller/songsProperties.dart';

class TopCard extends StatefulWidget {
  const TopCard({Key? key}) : super(key: key);

  @override
  State<TopCard> createState() => _TopCardState();
}

final AudioPlayer _audioPlayer = AudioPlayer();

class _TopCardState extends State<TopCard> {
  bool _isFavoriteSongsIcon = false;
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
          child: SongsProperties.ThumbImage,
            ),
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: size.width*.850,top: size.height*.012),
              child: InkWell(
                  onTap: (){
                      setState(() {
                        if(_isFavoriteSongsIcon==false) {
                        _isFavoriteSongsIcon = true;
                        }else{
                          _isFavoriteSongsIcon=false;
                        }
                        SongsProperties.FaveSongMusicName.add(SongsProperties.MusicName);
                        SongsProperties.FaveSongSingerName.add(SongsProperties.SingerName);
                      });
                  },
                  child: _isFavoriteSongsIcon? Icon(Icons.favorite_outline,color: Colors.white,):Icon(Icons.favorite,color: Colors.green,)),
            ),
          ],
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
                child: Lottie.asset("assets/lotties/barsmusic.json",animate: SongsProperties.Lottie,)
            )
        ),
      ],
    );
  }
}
