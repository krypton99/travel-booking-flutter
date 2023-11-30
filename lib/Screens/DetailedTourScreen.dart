import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:travel_booking_flutter_v2/Components/CustomAppBar.dart';
import 'package:travel_booking_flutter_v2/Models/Tour.dart';
import 'package:travel_booking_flutter_v2/Network/Api.dart';
import 'package:travel_booking_flutter_v2/Screens/CommentScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/SearchScreen.dart';
import 'package:travel_booking_flutter_v2/Screens/TourBookingScreen.dart';
import 'package:travel_booking_flutter_v2/Utils/Constants.dart';
import 'package:travel_booking_flutter_v2/main.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'PostScreen.dart';
import 'package:http/http.dart' as http;
const undefined = 'undefined';
Color mBackgroundColor = Color(0xFFFEFEFE);

Color mPrimaryColor = Color(0xFFf36f7c);

Color mSecondaryColor = Color(0xFFfff2f3);

class DetailedTourScreen extends StatefulWidget {
  final int? tourId;

  DetailedTourScreen(@required this.tourId);

  @override
  _DetailedTourScreenState createState() => _DetailedTourScreenState();
}
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: mPrimaryColor,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

class _DetailedTourScreenState extends State<DetailedTourScreen> {
  final double rating = 5;
   dynamic _progressDialog;

  // final String product="images/04.jpg";
  dynamic tour;
  var hasInstance;
  Tour defaultTour= Tour(id: 1, name: "", codeTour: "", startPlace: "", endPlace: "", province: "", national: "", startTime: "", endTime: "", time: "", status: "", description: "", avatarTour: "", discountPercent: 0, priceEntities: [], imageEntities: [], scheduleEntities: []);

  @override
  void initState() {
    super.initState();

    if(hasInstance==null){
      hasInstance=false;
    }
    Api.fetchTour(widget.tourId!).then((value) {
      setState(() {
        tour = value;
        hasInstance=true;
      });
    });
    _progressDialog = new ProgressDialog(context);
    _progressDialog.style(
        message: 'Vui lòng chờ...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    if(hasInstance==false)  {_progressDialog.show();} else {hasInstance=true; _progressDialog.hide();}
  }

  @override
  Widget build(BuildContext context) {



      return Scaffold(
        appBar: CustomAppBar(context, "Chi tiết tour", true),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(hasInstance) ProductImages(tour ?? defaultTour),
              if(hasInstance) PlaceAndName(tour ?? defaultTour),
              if(hasInstance) SizedBox(
                height: 36,
              ),
              if(hasInstance) About(tour ?? defaultTour),
              if(hasInstance) Padding(padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Yêu thích",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                  IconButton(
                    alignment: Alignment.center,
                    color: Colors.red,
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),),
              // Attrabute(tour),
              if(hasInstance) BookNowButton(tour ?? defaultTour),
            ],
          ),
        ),
      );
  }
}
Widget customWidget(Tour? tour, int i) {
  return Column(
    // spacing: 20, // to apply margin in the main axis of the wrap
    // runSpacing: 20,
    children: [
      Text(tour!.scheduleEntities[i]!.time.substring(0, 10) + ":"),
      Text(
        tour.scheduleEntities[i].place.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
Widget defaultWidget() {
  return Column(
    // spacing: 20, // to apply margin in the main axis of the wrap
    // runSpacing: 20,
    children: [
      Text("unknown"),
    ],
  );
}
class About extends StatelessWidget {
  final Tour tour;

  List<Widget> textWidgetList=<Widget>[];
  About(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    int legth;
    legth = tour.scheduleEntities.length;
    //textWidgetList=<Widget>[legth];
    for (int i = 0; i < legth; i++) {
      textWidgetList.add(customWidget(tour, i) );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Giới thiệu",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  ReadMoreText(
                    tour.description,
                    style: TextStyle(color: Colors.black),
                    trimLines: 2,
                    colorClickableText: Colors.black,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Xem thêm',
                    trimExpandedText: ' Ẩn ',
                  ),SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          Text(
            "Lịch trình",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: textWidgetList!,
                ),
              )),
        ],
      ),
    );
  }
}

class PlaceAndName extends StatelessWidget {
  final Tour tour;

  const PlaceAndName(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 12,
        bottom: 24,
      ),
      decoration: BoxDecoration(
          color: mSecondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          )),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                tour.name,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                // maxLines: 1,
                // softWrap: false,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tour == null ? 'Loading...' : tour.province,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [WebsafeSvg.asset('images/star.svg'), Text('4.8')],
              ),
              SizedBox(height: 10),
              Text(
                '${Constants.oCcy.format(tour.priceEntities[0].price)}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Attrabute extends StatelessWidget {
  final Tour tour;

  const Attrabute(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AttrabuteItem(
            iconUrl: 'images/mark.svg',
            isSelect: true,
          ),
          AttrabuteItem(
            iconUrl: 'images/compass.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/hotel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/travel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/share.svg',
          )
        ],
      ),
    );
  }
}

class AttrabuteItem extends StatelessWidget {
  final String? iconUrl;
  final bool? isSelect;
  final Tour? tour;

  const AttrabuteItem({
    this.iconUrl,
    this.isSelect = false,
    @required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelect! ? mPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          isSelect!
              ? BoxShadow()
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
        ],
      ),
      child: Image.asset(
        iconUrl!,
        color: isSelect! ? Colors.white : mPrimaryColor,
      ),
    );
  }
}

class BookNowButton extends StatelessWidget {
  final Tour tour;

  const BookNowButton(
    @required this.tour,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TourBookingScreen(tour),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            'Đặt ngay',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
      Key? key,
    this.trimExpandedText = ' read less',
    this.trimCollapsedText = ' ...read more',
        required this.colorClickableText,
        required this.style,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
  })  : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;


  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final overflow = defaultTextStyle.overflow;
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
        .copyWith(secondary: Colors.deepOrange);
    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).colorScheme.primary;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter? textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: link,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        print('linkSize $linkSize textSize $textSize');

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter!.getOffsetBefore(pos.offset) ?? 0;
        }
        else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          text: textSpan,
        );
      },
    );

    return result;
  }
}

class ProductImages extends StatefulWidget {
  ProductImages(
    @required this.tourImage,
  );
  Tour tourImage;
  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    //textWidgetList=<Widget>[legth];
    return Column(
      children: [
        SizedBox(
          width: 400,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.tourImage!.name,
              child: Image.network(
                  widget.tourImage!.imageEntities[selectedImage].image),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.tourImage!.imageEntities.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.tourImage!.imageEntities[index].image),
      ),
    );
  }
}
