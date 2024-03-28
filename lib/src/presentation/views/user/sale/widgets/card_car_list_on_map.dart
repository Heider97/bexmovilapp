/* import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';

class CardClientListOnMap extends StatefulWidget {
  final Client client;
  const CardClientListOnMap({super.key, required this.client});

  @override
  State<CardClientListOnMap> createState() => _CardClientListOnMapState();
}

class _CardClientListOnMapState extends State<CardClientListOnMap>
    with AutomaticKeepAliveClientMixin {
  late MapsBloc mapsBloc;
  @override
  void initState() {
    mapsBloc = BlocProvider.of<MapsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ThemeData theme = Theme.of(context);

    return BlocBuilder<MapsBloc, MapsBlocState>(
      builder: (context, state) {
        /*     Color backgroundcardColor = ColorLight.primary;
        Color textColor = Colors.white; */

        /*   if (state.selectedMapCarouselCar != widget.carListItemsData) {
          backgroundcardColor = Colors.white;
          textColor = Colors.black;
        } */

        return GestureDetector(
            onTap: () {
              mapsBloc.add(SelectClient(client: widget.client));
            },
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: OctoImage(
                        image: CachedNetworkImageProvider(
                            widget.carListItemsData.mainImage
                            ),
                        fit: BoxFit.cover,
                        width: 130,
                        height: 100,
                      ),
                    ), */
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*       Row(
                              children: [
                              /*   Icon(
                                  Icons.star,
                                  color: textColor,
                                ), */
                              /*   Text(
                                  "${widget.carListItemsData.ratingToHundredth}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ) */
                              ],
                            ), */
                            Text(
                              "Name : ${widget.client.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                //color: textColor
                              ),
                            ),
                            Text(
                              "lat : ${widget.client.latitude}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                //color: textColor
                              ),
                            ),
                            Text(
                              "lon : ${widget.client.longitude}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                //color: textColor
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
 */