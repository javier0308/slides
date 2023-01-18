import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SlidesShowWidget extends StatelessWidget {
  const SlidesShowWidget({
    super.key,
    required this.slides,
    this.dootTop = false,
    this.primaryColor = Colors.blue,
    this.secondColor = Colors.grey,
    this.bulletPrimario = 12,
    this.bulletSecundario = 12,
  });

  final bool dootTop;
  final Color primaryColor, secondColor;
  final List<Widget> slides;
  final double bulletPrimario, bulletSecundario;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideshowModel>(context).colorPrimario =
                  primaryColor;
              Provider.of<_SlideshowModel>(context).colorSecundario =
                  secondColor;
              Provider.of<_SlideshowModel>(context).bulletPrimario =
                  bulletPrimario;
              Provider.of<_SlideshowModel>(context).bulletSecundario =
                  bulletSecundario;
              return _CreateStructureSlideshow(
                  dootTop: dootTop, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CreateStructureSlideshow extends StatelessWidget {
  const _CreateStructureSlideshow({
    Key? key,
    required this.dootTop,
    required this.slides,
  }) : super(key: key);

  final bool dootTop;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dootTop) _Dots(slides.length),
        Expanded(
          child: _Slides(slides),
        ),
        if (!dootTop) _Dots(slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots(this.totalSlides);

  final int totalSlides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (i) => _Dot(i),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlideshowModel>(context);
    double tamano;
    Color color;
    if (slideshowModel.currentPage.round() == index) {
      tamano = slideshowModel.bulletPrimario;
      color = slideshowModel.colorPrimario;
    } else {
      tamano = slideshowModel.bulletSecundario;
      color = slideshowModel.colorSecundario;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides(this.slides);

  final List<Widget> slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(this.slide);

  final Widget slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlideshowModel extends ChangeNotifier {
  Color colorPrimario = Colors.blue;
  Color colorSecundario = Colors.grey;
  double _currentPage = 0;
  double bulletPrimario = 12, bulletSecundario = 12;

  double get currentPage => _currentPage;

  set currentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }
}
