

import 'package:just_audio/just_audio.dart';


class MyAudioPlayer  {

  MyAudioPlayer._();

 static MyAudioPlayer? _instance ;

 static MyAudioPlayer? getInstance() {
   _instance ??= MyAudioPlayer._();
   return _instance!;
 }

/*  static AudioPlayer? _instance2 ;

  static AudioPlayer? getInstance2() {
    _instance2 ??= AudioPlayer();
    return _instance2!;
  }*/
//  static final  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> init()  async{
  //  audioPlayer = AudioPlayer();
/*    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );*/
  }

 // AudioPlayer get audioPlayer => _audioPlayer;
/*  Future<void> playAudio(String audio) async {

    final audioPlayer = AudioPlayer();
    await audioPlayer.setSourceAsset("audio/$audio");
    await audioPlayer.resume();

  }*/





  Future<void> playAudio(String audio) async{
    final player = AudioPlayer();                   // Create a player
    await player.setAsset("assets/audio/notification30.mp3");
    await player.setVolume(100);
    await player.play();                            // Play while waiting for completion

  }

/*  Future<void> playAudioWithSeek(String audio) async{
    final player = AudioCache(prefix: "assets/audio/");
    final url = await player.load(audio);
    MyAudioPlayer.getInstance()!.audioPlayer.setSourceAsset(url.path);
    await MyAudioPlayer.getInstance()!.audioPlayer.seek(const Duration(milliseconds: 527));
    await MyAudioPlayer.getInstance()!.audioPlayer.resume();
  }*/
}