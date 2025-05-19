import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      'image':
          'https://raw.githubusercontent.com/Azul-Torres-1108/myapp/main/assets/one.png',
      'title': 'Symphony of Nature',
      'description':
          'Witness the grand canvas where ancient sequoias whisper timeless tales, and waterfalls sing melodies of serenity.',
    },
    {
      'image':
          'https://raw.githubusercontent.com/Azul-Torres-1108/myapp/main/assets/two.png',
      'title': 'The Sculpted Giant',
      'description':
          'El Capitan stands as nature’s masterpiece — a towering monument carved by patience and time, inspiring every soul who gazes upon it.',
    },
    {
      'image':
          'https://raw.githubusercontent.com/Azul-Torres-1108/myapp/main/assets/tree.png',
      'title': 'Granite Poetry',
      'description':
          'Half Dome rises like a sonnet in stone, its curves and edges narrating stories of resilience and silent strength.',
    },
    {
      'image':
          'https://raw.githubusercontent.com/Azul-Torres-1108/myapp/main/assets/for.png',
      'title': 'Eternal Horizon',
      'description':
          'The horizon blends earth and sky in a timeless dance, where every ray of light paints a new chapter in nature’s endless art.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(Icons.error, color: Colors.red, size: 50));
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    bottom: active ? 80 : 40,
                    left: 20,
                    right: 20,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      opacity: active ? 1.0 : 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(5, (index) {
                              return const FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['description']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'READ MORE',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Text(
              '${_currentPage + 1}/${items.length}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: items.length,
              effect: const WormEffect(
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
