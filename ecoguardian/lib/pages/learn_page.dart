import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '',
      params: const YoutubePlayerParams(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _initializePlayer(String videoUrl) {
    final videoId = YoutubePlayerController.convertUrlToId(videoUrl);
    if (videoId != null) {
      setState(() {
        _controller.load(videoId);
      });
    } else {
      print('Invalid video URL: $videoUrl');
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

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
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                _buildInfoCard(
                  'Reduce, Reuse, Recycle',
                  'Minimize waste by reducing, reusing, and recycling materials.',
                  'assets/image8.jpg',
                  () => _showDetails(
                    'Reduce, Reuse, Recycle',
                    'This principle aims to minimize waste, protect the environment, and conserve resources.',
                    'assets/image10.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Plant Trees',
                  'Trees provide oxygen and absorb CO2. Join tree planting initiatives!',
                  'assets/image9.jpg',
                  () => _showDetails(
                    'Plant Trees',
                    'Tree planting enhances biodiversity and combats climate change.',
                    'assets/image13.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Support Conservation Organizations',
                  'Volunteer or donate to groups dedicated to protecting the environment.',
                  'assets/image12.jpg',
                  () => _showDetails(
                    'Support Organizations',
                    'Your contribution helps in the fight against environmental degradation.',
                    'assets/image7.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Educational Videos',
                  'Watch videos to learn more about conservation efforts.',
                  'assets/image8.jpg',
                  () => _initializePlayer('https://youtu.be/HxsbXVlTAmo'),
                ),
                _buildInfoCard(
                  'Combat Soil Erosion',
                  'Learn about techniques to prevent soil erosion, such as planting cover crops.',
                  'assets/image2.jpg',
                  () => _showDetails(
                    'Combat Soil Erosion',
                    'Cover crops can help improve soil health and prevent erosion.',
                    'assets/image5.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Avoid Plastic Use',
                  'Reduce plastic usage by opting for reusable bags and containers.',
                  'assets/image2.jpg',
                  () => _showDetails(
                    'Avoid Plastic Use',
                    'Using reusable products can significantly reduce waste and protect wildlife.',
                    'assets/image3.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Educate Others',
                  'Share information about conservation with friends and family.',
                  'assets/image12.jpg',
                  () => _showDetails(
                    'Educate Others',
                    'Spreading awareness is crucial for community engagement in conservation.',
                    'assets/image9.jpg',
                  ),
                ),
                _buildInfoCard(
                  'Reduce Carbon Footprint',
                  'Use public transport, bike, or walk to reduce greenhouse gas emissions.',
                  'assets/image1.jpg',
                  () => _showDetails(
                    'Reduce Carbon Footprint',
                    'Small changes in transportation habits can lead to significant reductions in carbon emissions.',
                    'assets/image3.jpg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String description, String imagePath, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimationConfiguration.staggeredGrid(
        position: 0,
        duration: const Duration(milliseconds: 375),
        columnCount: 2, // Add this line
        child: ScaleAnimation(
          child: Card(
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4.0,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.asset(imagePath, fit: BoxFit.cover, height: 100),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetails(String title, String description, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important for preventing overflow
            children: [
              Image.asset(imagePath),
              const SizedBox(height: 10),
              Text(description),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
