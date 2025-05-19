import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_quiz_competition_platform/Views/Blog/blog_detail_page.dart';
import 'package:digital_quiz_competition_platform/Models/blog_model.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hardcoded blog data
    final List<BlogModel> blogs = [
      BlogModel(
        id: '1',
        title: 'How to Master Quiz Competitions',
        author: 'Quiz Expert',
        date: 'May 15, 2023',
        content:
            'Quiz competitions are a great way to test your knowledge and learn new things. '
            'To master quiz competitions, you need to develop a broad knowledge base, '
            'practice regularly, and learn to stay calm under pressure. '
            'Reading widely across different subjects, staying updated with current affairs, '
            'and participating in practice quizzes can significantly improve your performance. '
            'Remember, the key is consistency and curiosity!',
        imageUrl:
            'https://images.unsplash.com/photo-1606326608606-aa0b62935f2b',
        tags: ['Quiz', 'Learning', 'Competition'],
      ),
      BlogModel(
        id: '2',
        title: 'The Benefits of Regular Quizzing',
        author: 'Education Specialist',
        date: 'June 3, 2023',
        content:
            'Regular quizzing has numerous cognitive benefits. It enhances memory retention, '
            'improves recall abilities, and helps in developing critical thinking skills. '
            'Studies have shown that the act of retrieving information strengthens neural pathways, '
            'making it easier to access that information in the future. '
            'Additionally, quizzing exposes knowledge gaps, allowing for targeted learning. '
            'Make quizzing a part of your routine to see significant improvements in your learning efficiency.',
        imageUrl:
            'https://images.unsplash.com/photo-1434030216411-0b793f4b4173',
        tags: ['Education', 'Memory', 'Brain Training'],
      ),
      BlogModel(
        id: '3',
        title: 'Creating Effective Quiz Questions',
        author: 'Quiz Designer',
        date: 'July 20, 2023',
        content:
            'Designing effective quiz questions is both an art and a science. '
            'Good questions should be clear, unambiguous, and test understanding rather than mere memorization. '
            'They should be challenging but not impossible, and ideally, they should encourage critical thinking. '
            'When creating multiple-choice questions, ensure that all options are plausible. '
            'For open-ended questions, be specific about what you\'re looking for in the answer. '
            'Remember, the goal is to assess knowledge and promote learning, not to trick participants.',
        imageUrl:
            'https://images.unsplash.com/photo-1516321318423-f06f85e504b3',
        tags: ['Question Design', 'Assessment', 'Education'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blogs',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return BlogCard(blog: blog);
        },
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final BlogModel blog;

  const BlogCard({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailPage(blog: blog),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(
                blog.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(
                        blog.author,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(
                        blog.date,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    blog.content.length > 120
                        ? '${blog.content.substring(0, 120)}...'
                        : blog.content,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Wrap(
                    spacing: 8.0,
                    children: blog.tags.map((tag) {
                      return Chip(
                        label: Text(
                          tag,
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.purpleAccent,
                        padding: const EdgeInsets.all(0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
