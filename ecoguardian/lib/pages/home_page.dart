import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _city = 'Kampala'; // Default city
  String _weatherDescription = '';
  double? _temperature;
  double? _humidity;
  double? _windSpeed;
  double? _pressure;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Fetch weather data on init
  }

  Future<void> _fetchWeather() async {
    final apiKey =
        '855a33b3c795a0040d4f25656aaf4bd8'; // Replace with your OpenWeatherMap API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_city&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherDescription = data['weather'][0]['description'];
          _temperature = data['main']['temp'];
          _humidity = data['main']['humidity'].toDouble();
          _windSpeed = data['wind']['speed'].toDouble();
          _pressure = data['main']['pressure'].toDouble();
        });
      } else {
        print(
            'Failed to load weather data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  void _updateCity() {
    setState(() {
      _city = _cityController.text; // Update city from text field
      _fetchWeather(); // Fetch weather for the new city
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'ECO GUARDIAN',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Save the Environment, Save Our Future',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            _buildCarouselSlider(),
            const SizedBox(height: 16.0),
            // Input field for city
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _updateCity,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Display weather information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Weather in $_city',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  if (_temperature != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_temperature!.toStringAsFixed(1)}°C, $_weatherDescription',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        _buildWeatherDetailCard(
                            'Humidity', '$_humidity%', Icons.cloud),
                        _buildWeatherDetailCard(
                            'Wind Speed', '$_windSpeed m/s', Icons.air),
                        _buildWeatherDetailCard(
                            'Pressure', '$_pressure hPa', Icons.compress),
                      ],
                    ),
                  if (_temperature == null)
                    const CircularProgressIndicator(), // Show loading indicator while fetching
                ],
              ),
            ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/emergency_contacts');
              break;
            case 2:
              Navigator.pushNamed(context,
                  '/settings'); // Adjust when settings page is available
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40.0, color: Colors.green),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value, style: const TextStyle(fontSize: 14.0)),
                ],
              ),
            ),
          ],
        ),
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
}
