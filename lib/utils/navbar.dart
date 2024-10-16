import 'package:fancy_bottom_navigation_plus/components/tab_item.dart';
import 'package:flutter/material.dart';

class HalfPainter extends CustomPainter {
  HalfPainter(Color paintColor, this.height, {this.outline = 10}) {
    arcPaint = Paint()..color = paintColor;
  }

  late Paint arcPaint;
  final double? height;
  final double outline;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect =
        Rect.fromLTWH(0, (size.height / 2) - outline, outline, outline);
    final Rect largeRect = Rect.fromLTWH(
      outline,
      0,
      size.width - outline * 2,
      height ?? 40,
    );
    final Rect afterRect = Rect.fromLTWH(
        size.width - outline, (size.height / 2) - outline, outline, outline);

    final path = Path();
    path.arcTo(beforeRect, radians(0), radians(90), false);
    path.lineTo(outline * 2, size.height / 2);
    path.arcTo(largeRect, radians(0), -radians(180), false);
    path.moveTo(size.width - outline, size.height / 2);
    path.lineTo(size.width - outline, (size.height / 2) - outline);
    path.arcTo(afterRect, radians(180), radians(-90), false);
    path.close();

    canvas.drawPath(path, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degrees2Radians = 3.1415926535897932 / 180.0;
  double radians(double degrees) => degrees * degrees2Radians;
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class FancyBottomNavigationPlus extends StatefulWidget {
  const FancyBottomNavigationPlus({
    Key? key,
    this.barheight = 60,
    required this.tabs,
    required this.onTabChangedListener,
    this.animDuration = 0,
    this.initialSelection = 2,
    this.barBackgroundColor,
    this.circleRadius = 60,
    this.shadowRadius = 10,
    this.circleColor,
    this.titleStyle,
    this.circleOutline = 10,
  })  : assert(tabs.length > 1 && tabs.length < 6),
        super(key: key);

  final int animDuration;
  final Color? barBackgroundColor, circleColor;
  final int initialSelection;
  final Function(int position) onTabChangedListener;
  final double barheight, circleRadius, shadowRadius, circleOutline;
  final List<TabData> tabs;
  final TextStyle? titleStyle;

  @override
  State<FancyBottomNavigationPlus> createState() =>
      FancyBottomNavigationPlusState();
}

class FancyBottomNavigationPlusState extends State<FancyBottomNavigationPlus> {
  Widget activeIcon = const Icon(Icons.home);
  Widget nextIcon = const Icon(Icons.home);
  //  Arc is used to create sonme outline
  late double arcHeight, arcWidth;

  late Color barBackgroundColor;
  late Color circleColor;
  int currentSelected = 0;

  double _circleAlignX = 0;
  //  Opacity of the Icon
  double _circleIconAlpha = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    activeIcon = widget.tabs[currentSelected].icon;

    barBackgroundColor = widget.barBackgroundColor ?? Color(0xff000000);

    circleColor = widget.circleColor ?? (Color(0xffffffff));

    arcHeight = widget.circleRadius + widget.shadowRadius;
    arcWidth = widget.circleRadius + (widget.shadowRadius * 3);
  }

  @override
  void initState() {
    super.initState();
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  void _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].icon;
      });
    }
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: widget.animDuration ~/ 5), () {
      if (mounted) {
        setState(() {
          activeIcon = nextIcon;
        });
      }
    }).then((_) {
      Future.delayed(Duration(milliseconds: (widget.animDuration ~/ 5 * 3)),
          () {
        if (mounted) {
          setState(() {
            _circleIconAlpha = 1;
          });
        }
      });
    });
  }

  void setPage(int page) {
    widget.onTabChangedListener(page);
    _setSelected(widget.tabs[page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    if (mounted) {
      setState(() {
        currentSelected = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection = Directionality.of(context);
    bool isRtl = TextDirection.rtl == textDirection;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        //
        // Using this container to create the
        //  background and text contemts
        //
        Container(
            height: widget.barheight,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: barBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      spreadRadius: 0)
                ]),
            child: Row(
              children: widget.tabs
                  .map((t) => TabItem(
                        selected: t.key == widget.tabs[currentSelected].key,
                        title: t.title,
                        uniqueKey: t.key,
                        icon: t.icon,
                        animDuration: widget.animDuration,
                        titleStyle: widget.titleStyle,
                        callbackFunction: (uniqueKey) {
                          int selected = widget.tabs.indexWhere(
                              (tabData) => tabData.key == uniqueKey);
                          widget.onTabChangedListener(selected);
                          _setSelected(uniqueKey);
                          _initAnimationAndStart(_circleAlignX, 1);
                        },
                      ))
                  .toList(),
            )),

        //
        // Using this to create Icon Portion
        //

        Positioned.fill(
          top: -(widget.circleRadius +
                  widget.shadowRadius +
                  widget.circleOutline) /
              2,
          child: AnimatedAlign(
            duration: Duration(milliseconds: widget.animDuration),
            curve: Curves.easeOut,
            alignment: Alignment(isRtl ? -_circleAlignX : _circleAlignX, 1),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.barheight / 2,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / widget.tabs.length,
                child: GestureDetector(
                  onTap:
                      widget.tabs[currentSelected].onclick as void Function()?,
                  child: Stack(alignment: Alignment.center, children: [
                    //
                    // Container to render the Icon
                    //
                    Container(
                      transform: Matrix4.translationValues(0.0, 15.0, 0.0),
                      width: widget.circleRadius,
                      height: widget.circleRadius,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: circleColor),
                      child: activeIcon,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TabData {
  TabData({required this.icon, required this.title, this.onclick});

  Widget icon;
  final UniqueKey key = UniqueKey();
  Function? onclick;
  String title;
}
