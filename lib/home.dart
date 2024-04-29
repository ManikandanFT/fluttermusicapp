import 'package:flutter/material.dart';
import 'package:fluttermusicapp/const/colors.dart';
import 'package:fluttermusicapp/player.dart';
import 'package:fluttermusicapp/player_controller.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkcolor,
      appBar: (
      AppBar(
        title:  Text("Musicplayer",style: TextStyle(color: Colors.white),),
        backgroundColor:bgDarkcolor,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search,color: Colors.white,))],
      )
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioquery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
        ),
        builder:(BuildContext context,snapshot){
          if(snapshot.data==null){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.isEmpty){
            return const Center(child: Text(" No Sounds Found"));
          }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(
                            ()=> ListTile(
                          title: Text(snapshot.data![index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: Whitecolor),),
                          subtitle: Text("${snapshot.data![index].artist}",
                            maxLines: 1,
                            style: const TextStyle(color: Whitecolor),
                          ),
                          leading: QueryArtworkWidget(
                            id:snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Greencolor,
                                child: const Icon(Icons.music_note,
                                  size: 20,
                                  color: bgDarkcolor ,)
                            ),
                          ),
                          trailing: controller.playIndex.value == index && controller.IsPlaying.value ?
                          const Icon(Icons.play_arrow,size: 26,color: Colors.white,): null ,
                          onTap: (){
                             Get.to(()=> player(data: snapshot.data!),
                                 transition: Transition.downToUp,
                             );
                            controller.playsong(snapshot.data![index].uri,index);
                          },
                        ),
                      ),
                    );
                  }
              ),
            );
        },

      ),



    );
  }
}
