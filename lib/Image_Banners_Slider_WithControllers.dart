import 'dart:async';
import 'package:flutter/material.dart';

class ImageBannersSliderWithControllers extends StatefulWidget {
  final List imageBanners;
  final double sliderHeight;
  final bool autoPlay;
  final bool activeDots;
  final bool showArrowControllers;
  const ImageBannersSliderWithControllers(
      {Key? key,
      required this.imageBanners,
      required this.sliderHeight,
      required this.activeDots,
      required this.showArrowControllers,
      required this.autoPlay})
      : super(key: key);

  @override
  State<ImageBannersSliderWithControllers> createState() =>
      _ImageBannersSliderWithControllersState();
}

class _ImageBannersSliderWithControllersState
    extends State<ImageBannersSliderWithControllers> {
  late final PageController pageController;
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.75);
    carasouelTmer = widget.autoPlay ? getTimer() : null;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.sliderHeight,
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              pageNo = index;
              setState(() {});
              print(pageNo);
            },
            children: [
              for (int i = 0; i < widget.imageBanners.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: widget.imageBanners[i],
                ),
            ],
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.showArrowControllers
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (pageNo == 0) {
                            pageNo = widget.imageBanners.length;
                          }
                          pageController.animateToPage(pageNo,
                              duration: Duration(milliseconds: 0500),
                              curve: Curves.easeInCirc);
                          pageNo--;
                        });
                      },
                      child: Card(
                        elevation: 2,
                        child: Icon(
                          Icons.navigate_before,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.activeDots
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imageBanners.length,
                      (index) => GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.circle,
                            size: 12.0,
                            color: pageNo == index
                                ? Colors.indigoAccent
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.showArrowControllers
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (pageNo == widget.imageBanners.length) {
                            pageNo = 0;
                          }
                          pageController.animateToPage(pageNo,
                              duration: Duration(seconds: 0500),
                              curve: Curves.easeInCirc);
                          pageNo++;
                        });
                      },
                      child: Card(
                        elevation: 2,
                        child: Icon(
                          Icons.navigate_next,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }
}
