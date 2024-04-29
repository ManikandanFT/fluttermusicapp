import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusicapp/const/colors.dart';
import 'package:fluttermusicapp/player_controller.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class player extends StatelessWidget {
  final List<SongModel> data;

  const player({super.key,required this.data});

  @override
  Widget build(BuildContext context) {

    var controller= Get.find<PlayerController>();


    return Scaffold(
        backgroundColor: bgDarkcolor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                    const SizedBox(
                      height: 100,
                    ),
                    Obx(()=>
                      Center(

                        child: Column(
                          children: [
          
                               Container(
                                 height: 250,
                                 width: 250,
                                 clipBehavior: Clip.antiAliasWithSaveLayer,
                                 decoration: const BoxDecoration(
                                   shape: BoxShape.circle,
                                 ),
                                 child: QueryArtworkWidget(
                                  id: data[controller.playIndex.value].id,
                                  type: ArtworkType.AUDIO,
                                  artworkHeight: double.infinity,
                                  artworkWidth: double.infinity,
                                  artworkFit: BoxFit.cover,
                                  nullArtworkWidget: const Padding(
                                    padding:  EdgeInsets.all(8),
                                    child: Center(child: CircleAvatar(
                                      backgroundColor: Greencolor,
                                      maxRadius: 100,
                                      minRadius: 100,
                                      child: Icon(Icons.music_note,size: 80,color: bgDarkcolor),
                                    ),),
                                  ),
                                 ),
                               ),
          
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Obx(()=>
                       Center(
                        child: Text(
                          data[controller.playIndex.value].displayNameWOExt,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(()=>
                      Center(
                        child: Text(
                          data[controller.playIndex.value].artist.toString(),
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
          
                       Obx(()=>
                          Row(
                          children: [
                            // Text('${(_position.inMinutes % 60).toString().padLeft(2, '0')}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',),
                            Text(controller.position.value,style: TextStyle(color: Colors.white)),
                            Expanded(
                                child: Slider(
                                   thumbColor: Greencolor,
                                    activeColor: Greencolor,
                                    inactiveColor: Whitecolor,
                                    min: const Duration(seconds: 0).inSeconds.toDouble(),
                                    max: controller.max.value,
                                    value: controller.value.value,
                                    onChanged: (newvalue){
                                       controller.ChangedurationTosecond(newvalue.toInt());
                                       newvalue=newvalue;
                                    },
                                ),
                            ),
                            // Text('${(_position.inMinutes % 60).toString().padLeft(2, '0')}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',),
                            Text(controller.duration.value,style: const TextStyle(color: Colors.white)),
                          ],
                          ),
                       ),
          
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.playsong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 35,
                            color: Whitecolor,
                          ),
                        ),
          
                        Obx( ()=>
                           CircleAvatar(
                             radius: 35,
                             backgroundColor: Greencolor,
                             child: Transform.scale(
                               scale: 2.5,
                               child: IconButton(
                                  onPressed: () {
                                       if(controller.IsPlaying.value){
                                         controller.audioplayer.pause();
                                         controller.IsPlaying(false);
                                       }else
                                       {
                                         controller.audioplayer.play();
                                         controller.IsPlaying(true);
                                       }
                                  },
                                  icon:Icon(
                                    controller.IsPlaying.value? Icons.pause : Icons.play_arrow,
                                    size: 20,
                                    color: Whitecolor,
                                  ),
                                                       ),
                             ),
                           ),
                        ),
          
          
                        IconButton(
                            onPressed: () {
                              controller.playsong(data[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 35,
                              color: Whitecolor,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
