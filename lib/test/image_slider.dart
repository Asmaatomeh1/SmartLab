import 'package:appwithfirebase/core/theme/appcolor.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<String> images = [
    "assets/images/360_F_93974811_x14KnnNUtpAQCk8Ai2P3KItiVVioNJLA.jpg",
    "assets/images/360_F_93974811_x14KnnNUtpAQCk8Ai2P3KItiVVioNJLA.jpg",
    "assets/images/360_F_93974811_x14KnnNUtpAQCk8Ai2P3KItiVVioNJLA.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// الصور
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        /// dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentIndex == index ? 10 : 6,
              height: currentIndex == index ? 10 : 6,
              decoration: BoxDecoration(
                color: currentIndex == index ? AppColors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
