import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn about Conservation'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Introduction to Conservation'),
                const SizedBox(height: 8.0),
                _buildAnimatedText(
                  'Conservation is the practice of protecting the natural environment for the benefit of all living organisms. It includes preserving biodiversity, restoring habitats, and reducing pollution.',
                ),
                const SizedBox(height: 16.0),
                _buildSectionTitle('How to Conserve the Environment'),
                const SizedBox(height: 8.0),
                ..._buildInfoCards(),
                const SizedBox(height: 16.0),
                _buildSectionTitle('Environmental Conservation in Uganda'),
                const SizedBox(height: 8.0),
                _buildAnimatedText(
                  'Uganda is rich in biodiversity and natural resources. Here are some ways to help conserve the environment in Uganda:',
                ),
                ..._buildUgandaInfoCards(),
                const SizedBox(height: 16.0),
                _buildSectionTitle('Educational Videos'),
                const SizedBox(height: 8.0),
                ..._buildVideoCards(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Widget _buildAnimatedText(String text) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: const TextStyle(fontSize: 16.0),
          speed: const Duration(milliseconds: 50),
        ),
      ],
      totalRepeatCount: 1,
    );
  }

  List<Widget> _buildInfoCards() {
    return [
      _buildInfoCard(
        'Reduce, Reuse, Recycle',
        'Minimize waste by reducing what you use, reusing items, and recycling materials whenever possible.',
        'assets/image8.jpg', // Add your image path
      ),
      // Add more info cards here...
      // Example:
      _buildInfoCard(
        'Plant Trees',
        'Trees absorb carbon dioxide and provide oxygen. Participate in tree planting activities or start your own tree planting project.',
        'assets/image9.jpg', // Add your image path
      ),
      // Add the rest...
    ];
  }

  List<Widget> _buildUgandaInfoCards() {
    return [
      _buildInfoCard(
        'Support Conservation Organizations',
        'Donate to or volunteer with organizations working on conservation projects in Uganda.',
        'assets/image12.jpg', // Add your image path
      ),
      // Add more Uganda-specific info cards here...
    ];
  }

  List<Widget> _buildVideoCards() {
    return [
      _buildVideoCard(
        'Tree Planting in Uganda',
        'https://youtu.be/0mPurj3WS6M?si=bSqq0jT25UNPegnp',
      ),
      // Add more video cards here...
    ];
  }

  Widget _buildInfoCard(String title, String description, String imagePath) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 375),
      child: ScaleAnimation(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(String title, String videoUrl) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 375),
      child: ScaleAnimation(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Colors.black,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_fill,
                              size: 48.0, color: Colors.white),
                          onPressed: () {
                            _launchURL(videoUrl);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
