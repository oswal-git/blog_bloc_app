import 'package:blog_bloc_app/core/common/widgets/loader.dart';
import 'package:blog_bloc_app/core/routes/routes_name.dart';
import 'package:blog_bloc_app/core/theme/app_pallete.dart';
import 'package:blog_bloc_app/core/utils/show_snacbar.dart';
import 'package:blog_bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_bloc_app/features/blog/presentation/widgets/blog_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(GetAllBlogEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blog App'),
          actions: [
            IconButton(
              onPressed: () {
                context.push(newBlogRoute);
              },
              icon: Icon(Icons.add_circle),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailureState) {
              showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BlogLoadingState) {
              return Loader();
            }

            if (state is BlogDisplaySuccessState) {
              return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return BlogCardWidget(
                      blog: blog,
                      color: index % 3 == 0
                          ? AppPallete.gradient1
                          : index % 3 == 1
                              ? AppPallete.gradient2
                              : AppPallete.gradient3,
                    );
                  });
            }
            return SizedBox();
          },
        ));
  }
}
