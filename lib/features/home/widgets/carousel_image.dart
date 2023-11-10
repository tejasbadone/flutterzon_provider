import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'background_white_gradient.dart';
import 'bottom_offers.dart';
import 'custom_carousel_slider.dart';
import 'dots_indicator.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCarouselSliderMap(
            sliderImages: GlobalVariables.carouselImages,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        Positioned(
          top: 245,
          left: MediaQuery.sizeOf(context).width / 3.3,
          child: DotsIndicatorMap(
            controller: _controller,
            current: _current,
            sliderImages: GlobalVariables.carouselImages,
          ),
        ),
        const Positioned(
          bottom: 0,
          child: BackgroundWhiteGradient(),
        ),
        const Positioned(
          bottom: 0,
          child: BottomOffers(),
        ),
      ],
    );
  }
}
