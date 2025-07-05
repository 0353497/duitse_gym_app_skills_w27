import 'package:duitse_gym_app/data/json.dart';
import 'package:duitse_gym_app/models/studio.dart';
import 'package:flutter/material.dart';

class Newspage extends StatelessWidget {
  const Newspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: const Text(
          "Studio News",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Studio>>(
        future: DataLoader.getStudios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          }

          final studios = snapshot.data!;
          final studiosWithNews = studios.where((studio) => studio.news != null && studio.news!.isNotEmpty).toList();

          if (studiosWithNews.isEmpty) {
            return const Center(child: Text('No news available at the moment'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: studiosWithNews.length,
            itemBuilder: (context, index) {
              final studio = studiosWithNews[index];
              return NewsCard(studio: studio);
            },
          );
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Studio studio;

  const NewsCard({super.key, required this.studio});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/Icon.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  studio.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              studio.news!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Posted on July 5, 2025",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}