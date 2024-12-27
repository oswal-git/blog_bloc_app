import 'package:blog_bloc_app/core/routes/routes_name.dart';
import 'package:blog_bloc_app/core/theme/app_pallete.dart';
import 'package:blog_bloc_app/core/utils/calculate_reading_time.dart';
import 'package:blog_bloc_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogCardWidget extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCardWidget({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(viewBlogRoute, extra: blog),
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 9, top: 9, left: 16, right: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                  label: Text(e),
                                  side: BorderSide(
                                    color: AppPallete.borderColor,
                                  )),
                            ),
                          )
                          .toList()),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 50),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
