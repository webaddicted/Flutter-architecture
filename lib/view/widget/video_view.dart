import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/data/details/video_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:flutterarch/view/widget/video_player.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatelessWidget {
  final apiName;

  VideoView(this.apiName);

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context)); //getTradingList(context);
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieVideo;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data.results.length > 0
              ? getTradingList(context, jsonResult.data.results)
              : Container();
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget getTradingList(BuildContext context, List<Results> results) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: apiName),
        SizedBox(height: 10),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              var item = results[index];
              return Container(
                width: size.width - 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: getTitle(apiName) + index.toString(),
                        child: Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                width: size.width - 80,
                                child: ClipRRect(
                                  child: Image.network(
                                    'https://i.ytimg.com/vi/${item.key}/hqdefault.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          splashColor: Colors.redAccent,
                                          onTap: () {
                                            navigationPush(
                                                context,
                                                VideoPlayerScreen(
                                                  controller:
                                                      YoutubePlayerController(
                                                    initialVideoId:
                                                        'Qu9kmSQwfZw',
                                                    flags: YoutubePlayerFlags(
                                                      autoPlay: true,
//                  mute: true,
                                                    ),
                                                  ),
                                                ));
                                          }))),
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: ColorConst.WHITE_COLOR,
                                  size: 30.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: getTxtBlackColor(
                              msg: item.name,
                              fontSize: 15,
                              maxLines: 1,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
