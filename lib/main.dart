import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: YosemiteSlider(),
  ));
}

class YosemiteSlider extends StatefulWidget {
  const YosemiteSlider({super.key});

  @override
  State<YosemiteSlider> createState() => _YosemiteSliderState();
}

class _YosemiteSliderState extends State<YosemiteSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> items = [
    {
      'image': 'assets/one.png',
      'title': 'Yosemite National Park',
      'description':
          'Yosemite is famous for its giant, ancient sequoia trees and Tunnel View with Bridalveil Fall.',
    },
    {
      'image': 'assets/two.png',
      'title': 'El Capitan',
      'description':
          'El Capitan is a vertical rock formation in Yosemite, attracting climbers worldwide.',
    },
    {
      'image': 'assets/tree.png',
      'title': 'Half Dome',
      'description':
          'Half Dome is a granite dome, one of the park’s most recognized features.',
    },
    {
      'image': 'assets/for.png',
      'title': 'Half Dome',
      'description':
          'Half Dome is a granite dome, one of the park’s most recognized features.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Página deslizable con la interacción
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final bool active = index == _currentPage;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Mostrar la imagen
                  Image(image: AssetImage(item['image']!), fit: BoxFit.cover),
                  // Filtro de gradiente para el texto
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    bottom: active ? 80 : 40,
                    left: 20,
                    right: 20,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 700),
                      opacity: active ? 1.0 : 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(5, (index) {
                              return const Icon(Icons.star, color: Colors.amber, size: 16);
                            }),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['description']!,
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: const Text('READ MORE', style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Indicador de página
          Positioned(
            top: 50,
            right: 20,
            child: Text(
              '${_currentPage + 1}/${items.length}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Control del SmoothPageIndicator
          Positioned(
            bottom: 20,
            left: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: items.length,
              effect: WormEffect(
                dotColor: Colors.white38,
                activeDotColor: Colors.white,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
