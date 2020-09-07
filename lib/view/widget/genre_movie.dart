import 'package:flutter/widgets.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/details/movie_details_respo.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/movie_list_screen.dart';

class GenreMovie extends StatelessWidget {
  const GenreMovie({
    Key key,
    @required List<Genres> items,
    Color textColor,
    Color borderColor,
  })  : _items = items,
        _textColor = textColor,
        _borderColor = borderColor,
        super(key: key);

  final List<Genres> _items;
  final Color _textColor;
  final Color _borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Tags(
        itemCount: _items.length, // required
        itemBuilder: (int index) {
          final item = _items[index];
          return ItemTags(
            key: Key(index.toString()),
            index: index, // required
            title: item.name,
            active: false,
            textStyle: TextStyle(fontSize: 12),
            elevation: 0,
            textColor: ColorConst.APP_COLOR,
            border: Border.all(
              color: ColorConst.APP_COLOR,
            ),
            onLongPressed: null,
            onPressed: (datte) => navigationPush(
                context,
                MovieListScreen(
                    apiName: StringConst.MOVIE_CATEGORY,
                    dynamicList: item.name,
                    movieId: item.id))
          );
        },
      ),
    );
  }
}
