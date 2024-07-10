import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    ReportIssueTab(),
    LearnTab(),
    NotificationsTab(),
    ProfileTab(),
    EmergencyContactsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eco Guardian',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report Issue'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Learn'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Emergency Contacts'),
              onTap: () {
                _onItemTapped(5);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Save your environment to save the future',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildCarouselSlider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCard(
                  icon: Icons.report,
                  title: 'Report Environmental Issues',
                  description: 'Notify authorities about environmental issues.',
                  onTap: () {
                    Navigator.pushNamed(context, '/report');
                  },
                ),
                _buildCard(
                  icon: Icons.info,
                  title: 'Learn about Conservation',
                  description:
                      'Get information on how to conserve the environment.',
                  onTap: () {
                    Navigator.pushNamed(context, '/learn');
                  },
                ),
                _buildCard(
                  icon: Icons.notifications,
                  title: 'Receive Notifications',
                  description: 'Stay updated with the latest news and alerts.',
                  onTap: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
                _buildCard(
                  icon: Icons.account_circle,
                  title: 'Manage Profile',
                  description: 'Update your profile and settings.',
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Contacts',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildContactCard(
                  'NEMA',
                  'National Environment Management Authority',
                  'Phone: +256 414 251064\nEmail: info@nema.go.ug',
                ),
                _buildContactCard(
                  'NWSC',
                  'National Water and Sewerage Corporation',
                  'Phone: +256 414 315800\nEmail: info@nwsc.co.ug',
                ),
                _buildContactCard(
                  'NFA',
                  'National Forestry Authority',
                  'Phone: +256 414 233167\nEmail: info@nfa.org.ug',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Environmental Awareness Activities',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildAwarenessCard(
                  title: 'Clean-Up Campaigns',
                  description:
                      'Organize and participate in local clean-up events to keep your environment clean.',
                ),
                _buildAwarenessCard(
                  title: 'Tree Planting Initiatives',
                  description:
                      'Join tree planting events to contribute to reforestation efforts.',
                ),
                _buildAwarenessCard(
                  title: 'Waste Management Programs',
                  description:
                      'Learn about proper waste segregation, recycling, and composting practices.',
                ),
                _buildAwarenessCard(
                  title: 'Water Conservation',
                  description:
                      'Discover ways to reduce water usage and promote water conservation.',
                ),
                _buildAwarenessCard(
                  title: 'Energy Conservation',
                  description:
                      'Get tips on reducing energy consumption and using renewable energy sources.',
                ),
                _buildAwarenessCard(
                  title: 'Sustainable Living',
                  description:
                      'Adopt sustainable lifestyle choices and support eco-friendly products.',
                ),
                _buildAwarenessCard(
                  title: 'Wildlife Conservation',
                  description:
                      'Learn how to protect local wildlife and their habitats.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    List<String> images = [
      'assets/image1.jpg',
      'assets/image2.jpg',
      'assets/image3.jpg',
      'assets/image4.jpg',
      'assets/image5.jpg',
    ];

    List<String> messages = [
      'Join us in protecting our environment.',
      'Small actions can make a big difference.',
      'Plant a tree, save the future.',
      'Reduce, Reuse, Recycle.',
      'Together for a greener planet.',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        aspectRatio: 2.0,
      ),
      items: images.asMap().entries.map((entry) {
        int index = entry.key;
        String image = entry.value;
        String message = messages[index];

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.black54,
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.green,
              ),
              const SizedBox(width: 16.0),
              Expanded(
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
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(String title, String subtitle, String contactInfo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
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
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              contactInfo,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwarenessCard({
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
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
            Text(
              description,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportIssueTab extends StatelessWidget {
  const ReportIssueTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Report Issue Page'),
    );
  }
}

class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Learn Page'),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notifications Page'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Page'),
    );
  }
}

class EmergencyContactsTab extends StatelessWidget {
  const EmergencyContactsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Emergency Contacts Page'),
    );
  }
}
