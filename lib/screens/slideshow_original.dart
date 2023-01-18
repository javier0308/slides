import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_show_perso/widgets/slides.dart';

class SlideshowScreenO extends StatelessWidget {
  const SlideshowScreenO({Key? key}) : super(key: key);

  static const String route = 'original';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(child: MiSlideShow()),
          Expanded(child: MiSlideShow()),
        ],
      ),
    );
  }
}

class MiSlideShow extends StatelessWidget {
  const MiSlideShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidesShowWidget(
      bulletPrimario: 20,
      // dootTop: true,
      primaryColor: Colors.pink,
      // secondColor: Colors.black,
      slides: [
        SvgPicture.asset('assets/slide-1.svg'),
        SvgPicture.asset('assets/slide-2.svg'),
        SvgPicture.asset('assets/slide-3.svg'),
        SvgPicture.asset('assets/slide-4.svg'),
        SvgPicture.asset('assets/slide-5.svg'),
      ],
    );
  }
}
