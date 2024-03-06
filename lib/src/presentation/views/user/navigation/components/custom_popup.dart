import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomPopup extends StatefulWidget {
  static CustomPopupState? of(BuildContext context) =>
      context.findAncestorStateOfType<CustomPopupState>();

  const CustomPopup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomPopupState();
  }
}

class CustomPopupState extends State<CustomPopup> {
  late Future<void> _initializeVideoPlayerFuture;
  late VideoPlayerController controller;
  IconData playerIcon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(
      'assets/video/bike_acrobatics.mp4',
    );

    _initializeVideoPlayerFuture = controller.initialize();

    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Container _buildDialogContent() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: 279.0,
      height: 256.0,
      child: Stack(
        children: <Widget>[
          _buildVideoContainer(),
          Container(
            margin: const EdgeInsets.only(top: 159.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAvatar(),
                _buildNameAndLocation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContainer() {
    return Container(
      color: Colors.white,
      height: 172.0,
      child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? VideoPlayer(controller)
                  : const Center(child: CircularProgressIndicator());
            },
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                  playerIcon = Icons.play_arrow;
                } else {
                  controller.play();
                  playerIcon = Icons.pause;
                }
              });
            },
            child: Stack(
              children: <Widget>[
                Center(
                  child:
                      Image.asset('assets/images/ic_blurred_gray_circle/ic_blurred_gray_circle.png'),
                ),
                Center(
                  child: Icon(
                    playerIcon,
                    color: const Color.fromRGBO(34, 43, 47, 100),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildAvatar() {
    return Container(
        width: 55.0,
        height: 55.0,
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const CircleAvatar(
          backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
        ));
  }

  Expanded _buildNameAndLocation() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 6.0, top: 20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('Johnatan Lawrence')),
                Text('1')
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(102, 122, 133, 100),
                  size: 13.0,
                ),
                Text("Blue Lake Park"),
                Expanded(
                  child: Text(
                    '6',
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
