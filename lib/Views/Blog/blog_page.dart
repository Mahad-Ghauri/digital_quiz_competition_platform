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
        title: 'Understanding Your Civic Duties',
        author: 'Civic Sensei',
        date: 'June 5, 2023',
        content:
            'Civic duties are the responsibilities expected of citizens in a democratic society. '
            'These include voting in elections, paying taxes, obeying laws, and staying informed. '
            'By fulfilling your civic duties, you help strengthen your community and contribute to good governance. '
            'Understanding these roles helps you become a more active and responsible citizen.',
        imageUrl:
            'https://images.unsplash.com/photo-1581091870622-1c1b601a84a2',
        tags: ['Civics', 'Citizenship', 'Responsibility'],
      ),
      BlogModel(
        id: '3',
        title: 'Why Community Engagement Matters',
        author: 'Community Voice',
        date: 'July 12, 2023',
        content:
            'Community engagement is the backbone of a vibrant and connected society. '
            'It encourages collaboration, builds trust, and helps solve local problems. '
            'When people participate in community activities, they create positive change and strengthen social ties. '
            'From volunteering to town hall meetings, every action makes a difference.',
        imageUrl: 'https://images.unsplash.com/photo-1556761175-129418cb2dfe',
        tags: ['Community', 'Engagement', 'Social Impact'],
      ),
      BlogModel(
        id: '4',
        title: 'The Power of Youth in Civic Action',
        author: 'NextGen Leader',
        date: 'August 21, 2023',
        content:
            'Young people play a critical role in shaping the future through civic engagement. '
            'By participating in campaigns, policy discussions, and volunteer work, they bring fresh ideas and energy. '
            'Encouraging youth involvement not only strengthens democracy but also helps develop future leaders. '
            'Empowering the youth is essential for long-term societal growth.',
        imageUrl:
            'https://images.unsplash.com/photo-1520975918318-2eec94b7f266',
        tags: ['Youth', 'Civic Action', 'Leadership'],
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
