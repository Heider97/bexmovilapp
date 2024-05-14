import 'package:flutter/material.dart';
import '../../../../../domain/models/responses/nearby_places_response.dart';

class CustomPopup extends StatefulWidget {
  final Results place;
  static CustomPopupState? of(BuildContext context) =>
      context.findAncestorStateOfType<CustomPopupState>();

  const CustomPopup({Key? key, required this.place}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomPopupState();
  }
}

class CustomPopupState extends State<CustomPopup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Container _buildDialogContent() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: 279.0,
      height: 256.0,
      child: Stack(
        children: <Widget>[
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
