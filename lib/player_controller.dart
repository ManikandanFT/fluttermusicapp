import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:on_audio_query/on_audio_query.dart';
class PlayerController extends GetxController{

  final audioquery= OnAudioQuery();
  final audioplayer= AudioPlayer();

  var playIndex= 0.obs;
  var IsPlaying= false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max= 0.0.obs;
  var value= 0.0.obs;

  updatePosition(){
    audioplayer.durationStream.listen((d) {
      //duration.value=d.toString().split(".")[0];
      String formattedTime = '${(d!.inMinutes).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
      duration.value = formattedTime;
      max.value=d.inSeconds.toDouble();
    });
    audioplayer.positionStream.listen((p) {

     // position.value=p.toString().split(".")[0];
      String formattedTime = '${(p.inMinutes).toString().padLeft(2, '0')}:${(p.inSeconds % 60).toString().padLeft(2, '0')}';
      position.value = formattedTime;
      value.value=p.inSeconds.toDouble();

    });

  }

   ChangedurationTosecond(seconds){
    var duration =Duration(seconds: seconds );
    audioplayer.seek(duration);
   }



 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Checkpermission();
  }

  playsong(String ?  uri,index,){
   playIndex.value=index;
    try{
      audioplayer.setAudioSource(
          AudioSource.uri(Uri.parse(uri!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id:uri,
              // Metadata to display in the notification:
              album: "",
              artUri: Uri.parse('https://example.com/albumart.jpg'),
              title: '',
            ),
          ),

      );
      audioplayer.play();
      IsPlaying(true);
      updatePosition();
    }
    on Exception catch(e) {
      print(e.toString());
    }
   }


   Checkpermission () async {
   var perm= await  Permission.storage.request();
   if(perm.isGranted){
   }
   else{
     Checkpermission();
   }
  }








}