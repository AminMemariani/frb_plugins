import 'package:flutter/material.dart';

import 'package:smtc_windows/smtc_windows.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SMTCWindows.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SMTCWindows smtc;

  @override
  void initState() {
    smtc = SMTCWindows(
      metadata: const MusicMetadata(
        title: 'Title',
        album: 'Album',
        albumArtist: 'Album Artist',
        artist: 'Artist',
        thumbnail:
            'https://media.glamour.com/photos/5f4c44e20c71c58fc210d35f/master/w_2560%2Cc_limit/mgid_ao_image_mtv.jpg',
      ),
      timeline: const PlaybackTimeline(
        startTimeMs: 0,
        endTimeMs: 1000,
        positionMs: 0,
        minSeekTimeMs: 0,
        maxSeekTimeMs: 1000,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        smtc.buttonPressStream.listen((event) {
          switch (event) {
            case PressedButton.play:
              smtc.setPlaybackStatus(PlaybackStatus.playing);
              break;
            case PressedButton.pause:
              smtc.setPlaybackStatus(PlaybackStatus.paused);
              break;
            case PressedButton.next:
              print('Next');
              break;
            case PressedButton.previous:
              print('Previous');
              break;
            case PressedButton.stop:
              smtc.setPlaybackStatus(PlaybackStatus.stopped);
              smtc.disableSmtc();
              break;
            default:
              break;
          }
        });
      } catch (e) {
        debugPrint("Error: $e");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    smtc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: ElevatedButton(
          child: const Text("Click"),
          onPressed: () {
            smtc.updateMetadata(
              const MusicMetadata(
                title: 'Title',
                album: 'Album',
                albumArtist: 'Album Artist',
                artist: 'Artist',
                thumbnail:
                    'https://media.glamour.com/photos/5f4c44e20c71c58fc210d35f/master/w_2560%2Cc_limit/mgid_ao_image_mtv.jpg',
              ),
            );
          },
        ),
      ),
    );
  }
}
