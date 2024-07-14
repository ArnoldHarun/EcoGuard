import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'video_player_page.dart'; // Import the VideoPlayerPage

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final List<Map<String, String>> videos = [
    {
      'title': 'Conservation Basics',
      'url': 'https://youtu.be/mz4zUTOuZyw?si=v8ok_cWhIpWJLDPJ',
    },
    {
      'title': 'The Importance of Biodiversity',
      'url': 'https://youtu.be/some_other_video_url',
    },
    {
      'title': 'Sustainable Practices',
      'url': 'https://youtu.be/yet_another_video_url',
    },
    // Add more videos as needed
  ];

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
                  _navigateToVideoList,
                ),
                // Add more cards as needed
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
        columnCount: 2,
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

  void _navigateToVideoList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoListPage(videos: videos),
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
            mainAxisSize: MainAxisSize.min,
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

class VideoListPage extends StatelessWidget {
  final List<Map<String, String>> videos;

  const VideoListPage({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Videos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videos[index]['title']!),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/video',
                arguments: videos[index]['url'],
              );
            },
          );
        },
      ),
    );
  }
}
