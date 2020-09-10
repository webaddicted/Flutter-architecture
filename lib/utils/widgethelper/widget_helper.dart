import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/utils/SlideRoute.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';

//  {START PAGE NAVIGATION}
// void navigationPush(BuildContext context, StatefulWidget route) {
//   Navigator.push(context, MaterialPageRoute(
//     builder: (context) {
//       return route;
//     },
//   ));
// }
// void navigationPop(BuildContext context, StatefulWidget route) {
//   Navigator.pop(context, MaterialPageRoute(builder: (context) {
//     return route;
//   }));
// }
void navigationPush(BuildContext context, StatefulWidget route) {
  Navigator.push(context, RouteTransition(widget: route));
}

void navigationPop(BuildContext context, StatefulWidget route) {
  Navigator.pop(context, RouteTransition(widget: route));
}

void navigationStateLessPush(BuildContext context, StatelessWidget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPop(BuildContext context, StatelessWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void delay(BuildContext context, int duration, StatefulWidget route) {
  Future.delayed(const Duration(seconds: 3), () {
    navigationPush(context, route);
  });
}

//  {END PAGE NAVIGATION}

Widget apiHandler<T>({ApiResponse<T> response, Widget loading, Widget error}) {
  switch (response.status) {
    case ApiStatus.LOADING:
      debugPrint("LOADING");
      return loading != null ? loading : Loading();
      break;
    case ApiStatus.ERROR:
      debugPrint("ERROR");
      return error != null
          ? error
          : Error(
              errorMessage: response.apierror.errorMessage,
              onRetryPressed: () {
                //call api
              },
            );
      break;
    default:
      {
        return Container(
          color: Colors.amber,
        );
      }
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "loadingMessage",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}

AppBar getAppBarWithBackBtn(
    {@required BuildContext ctx,
    String title,
    Color bgColor,
    double fontSize,
    String titleTag,
    Widget icon}) {
  return AppBar(
    backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
    leading: icon,
    centerTitle: true,
    title: Hero(
      tag: titleTag == null ? "" : titleTag,
      child: new Text(
        title,
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConst.BLACK_COLOR,
            fontSize: fontSize != null ? fontSize : 16),
      ),
    ),
  );
}

//  {START TEXT VIEW}
Text getTxt(
    {@required String msg,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(msg,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: AssetsConst.ZILLASLAB_FONT,
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight));
}

Text getTxtAppColor(
    {@required String msg,
    double fontSize,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    style: _getFontStyle(
        txtColor: ColorConst.APP_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtWhiteColor(
    {@required String msg,
    double fontSize,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(
    msg,
    maxLines: maxLines,
    textAlign: textAlign,
    style: _getFontStyle(
        txtColor: ColorConst.WHITE_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtBlackColor(
    {@required String msg,
    double fontSize,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: ColorConst.BLACK_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtGreyColor(
    {@required String msg,
    double fontSize,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: ColorConst.GREY_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtColor(
    {@required String msg,
    @required Color txtColor,
    double fontSize,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign}) {
  return Text(
    msg,
    textAlign: textAlign,
    maxLines: maxLines,
    style: _getFontStyle(
        txtColor: txtColor, fontSize: fontSize, fontWeight: fontWeight),
  );
}

TextStyle _getFontStyle(
    {Color txtColor,
    double fontSize,
    FontWeight fontWeight,
    String fontFamily,
    TextDecoration txtDecoration}) {
  return TextStyle(
      color: txtColor,
      fontSize: fontSize != null ? fontSize : 14,
      decoration: txtDecoration == null ? TextDecoration.none : txtDecoration,
      fontFamily: fontFamily == null ? AssetsConst.ZILLASLAB_FONT : fontFamily,
      fontWeight: fontWeight == null ? FontWeight.normal : fontWeight);
}

//  {END TEXT VIEW}

// ClipRRect loadLocalCircleImg(String imagePath, double radius) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: new FadeInImage.assetNetwork(
//         height: radius,
//         width: radius,
//         fit: BoxFit.fill,
//         placeholder: imagePath,
//         image: 'imgUrl'),
//   );
// }
//
// FadeInImage loadImg(String url, int placeHolderPos) {
//   return new FadeInImage.assetNetwork(
//       fit: BoxFit.fill,
//       placeholder: _getPlaceHolder(placeHolderPos),
//       image: url);
// }
//
// ClipRRect loadCircleImg(String imgUrl, int placeHolderPos, double radius) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: new FadeInImage.assetNetwork(
//         height: radius,
//         width: radius,
//         fit: BoxFit.fill,
//         placeholder: _getPlaceHolder(placeHolderPos),
//         image: imgUrl),
//   );
// }

String _getPlaceHolder(int placeHolderPos) {
  switch (placeHolderPos) {
    case 0:
      return AssetsConst.LOGO_IMG;
    default:
      return AssetsConst.LOGO_IMG;
  }
}
ClipRRect loadCircleCacheImg(String url, double radius) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: getCacheImage(url:url, height:radius, width: radius)
  );
}
Widget getCacheImage({String url, double height, double width}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    width: width != null ? width : double.infinity,
    height: height != null ? height : double.infinity,
    imageUrl: url,
    placeholder: (context, url) => Container(
      width: width != null ? width : double.infinity,
      height: height != null ? height : double.infinity,
      color: Colors.grey[400],
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Divider getDivider() {
  return Divider(
    color: ColorConst.GREY_COLOR,
    height: 1,
  );
}
