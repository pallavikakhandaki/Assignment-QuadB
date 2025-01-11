import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Details Screen
class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[400],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFAD1457),
                Color(0xFFF48FB1),
              ], // Light pink to dark pink
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                (movie['name'] ?? 'Movie Details'),
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Image (Full Size)
            if (movie['image'] != null)
              Image.network(movie['image']['original']),

            // Movie Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['name'] ?? 'No Title',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Movie Summary
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['summary'] != null
                    ? (movie['summary'] as String)
                        .replaceAll(RegExp(r'<[^>]*>'), '') // Clean up HTML
                    : 'No Summary Available',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            // Movie Language
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Language: ${movie['language'] ?? 'N/A'}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Category: ${movie['genres'] ?? 'N/A'}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Web Channel: ${movie['webChannel']?['name'] ?? 'N/A'}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            // Premiered Date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Premiered: ${movie['premiered'] ?? 'N/A'}',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating: ${movie['rating']['average'] ?? 'N/A'}',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      10, // Maximum number of stars (assuming 10 as max rating)
                      (index) {
                        // Determine if the star is filled based on the rating
                        bool isFilled = (movie['rating']['average'] != null &&
                            movie['rating']['average'] > index);
                        return Icon(
                          isFilled ? Icons.star : Icons.star_border,
                          color: Colors.yellow[700], // Star color
                          size: 24.0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Country Information (if available)
            if (movie['network'] != null && movie['network']['country'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Country: ${movie['network']['country']['name'] ?? 'N/A'}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
