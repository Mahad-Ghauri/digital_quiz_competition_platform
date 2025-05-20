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
        title: 'Understanding Your Civic Duties',
        author: 'Civic Sensei',
        date: 'June 5, 2023',
        content:
            'Civic duties are the responsibilities expected of citizens in a democratic society. '
            'These include voting in elections, paying taxes, obeying laws, and staying informed. '
            'By fulfilling your civic duties, you help strengthen your community and contribute to good governance. '
            'Understanding these roles helps you become a more active and responsible citizen.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1733342422588-c2fc9e279836?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cmVzcG9uc2liaWxpdHl8ZW58MHx8MHx8fDA%3D',
        tags: ['Civics', 'Citizenship', 'Responsibility'],
      ),
      BlogModel(
        id: '2',
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
        id: '3',
        title: 'Why Community Engagement Matters',
        author: 'Community Voice',
        date: 'July 12, 2023',
        content:
            'Community engagement is the backbone of a vibrant and connected society. '
            'It encourages collaboration, builds trust, and helps solve local problems. '
            'When people participate in community activities, they create positive change and strengthen social ties. '
            'From volunteering to town hall meetings, every action makes a difference.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1708598525588-eae2b2d05a9e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
            'https://images.unsplash.com/photo-1593896385987-16bcbf9451e5?q=80&w=1994&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        tags: ['Youth', 'Civic Action', 'Leadership'],
      ),
      BlogModel(
        id: '5',
        title: 'Your Vote, Your Voice: Why Voting Matters',
        author: 'Democracy Defender',
        date: 'September 9, 2023',
        content:
            'Voting is a fundamental right and a powerful way to influence change. '
            'Every election shapes policies that affect healthcare, education, and the environment. '
            'By casting your vote, you contribute to the democratic process and ensure your voice is heard. '
            'An informed vote is the first step toward meaningful change.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1708938893194-eaa4bf9efffd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHZvdGluZ3xlbnwwfHwwfHx8MA%3D%3Dd920f1fb7238',
        tags: ['Voting', 'Democracy', 'Rights'],
      ),
      BlogModel(
        id: '6',
        title: 'Protecting Our Planet Through Civic Action',
        author: 'Eco Advocate',
        date: 'October 2, 2023',
        content: 'Environmental issues require active civic participation. '
            'From supporting green policies to organizing clean-up drives, your actions matter. '
            'Contacting local representatives, reducing waste, and raising awareness are key steps. '
            'Civic responsibility includes protecting the environment for future generations.',
        imageUrl:
            'https://images.unsplash.com/photo-1564669733547-c6ca390e11c5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGVudmlyb25tZW50fGVufDB8fDB8fHww',
        tags: ['Environment', 'Civic Action', 'Sustainability'],
      ),
      BlogModel(
        id: '7',
        title: 'Know Your Rights: A Citizen’s Guide',
        author: 'Legal Light',
        date: 'November 10, 2023',
        content:
            'Understanding your rights empowers you to stand up for justice and fairness. '
            'Whether it’s freedom of speech, the right to a fair trial, or the right to protest, '
            'being informed helps you protect yourself and others. '
            'Civic education is essential in building a society where rights are respected and upheld.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1668058723804-d7dcd1ffa4c9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8anVzdGljZXxlbnwwfHwwfHx8MA%3D%3D',
        tags: ['Rights', 'Law', 'Civic Education'],
      ),
      BlogModel(
        id: '8',
        title: 'The Role of Activism in a Healthy Democracy',
        author: 'Change Catalyst',
        date: 'December 5, 2023',
        content:
            'Activism helps raise awareness about important issues and pressures leaders to act. '
            'From peaceful protests to online campaigns, it’s a vital part of democracy. '
            'Activists amplify voices that might otherwise go unheard and drive policy change. '
            'Informed and peaceful activism can reshape societies for the better.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1679429321023-dff2ea455b0c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNvbW11bml0eXxlbnwwfHwwfHx8MA%3D%3D',
        tags: ['Activism', 'Democracy', 'Change'],
      ),
      BlogModel(
        id: '9',
        title: 'Building Inclusive Communities',
        author: 'Unity Builder',
        date: 'January 18, 2024',
        content:
            'An inclusive community values diversity and ensures that everyone feels welcome. '
            'It involves recognizing different identities and creating equal opportunities. '
            'Through civic participation, people can foster mutual respect and social equity. '
            'Inclusion is key to a stronger, more united society.',
        imageUrl:
            'https://images.unsplash.com/photo-1591197172062-c718f82aba20?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29tbXVuaXR5fGVufDB8fDB8fHww',
        tags: ['Inclusion', 'Community', 'Equality'],
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
