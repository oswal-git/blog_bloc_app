import 'dart:io';

import 'package:blog_bloc_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_bloc_app/core/common/widgets/loader.dart';
import 'package:blog_bloc_app/core/constants/constants.dart';
import 'package:blog_bloc_app/core/routes/routes_name.dart';
import 'package:blog_bloc_app/core/theme/app_pallete.dart';
import 'package:blog_bloc_app/core/utils/pick_image.dart';
import 'package:blog_bloc_app/core/utils/show_snacbar.dart';
import 'package:blog_bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_bloc_app/features/blog/presentation/widgets/blog_editor_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectTopics = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() && selectTopics.isNotEmpty && image != null) {
      final posterId = (context.read<AppUserCubit>().state as AppUserLoggedInState).user.id;
      context.read<BlogBloc>().add(
            BlogUploadEvent(
              posterId: posterId,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              image: image!,
              topics: selectTopics,
            ),
          );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Blog'),
        actions: [
          IconButton(
            onPressed: uploadBlog,
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailureState) {
            showSnackbar(context, state.message);
          }
          if (state is BlogUploadSuccessState) {
            context.go(blogRoute);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  image != null
                      ? SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            color: AppPallete.borderColor,
                            borderType: BorderType.RRect,
                            dashPattern: const [10, 10],
                            radius: const Radius.circular(10),
                            strokeWidth: 4,
                            strokeCap: StrokeCap.round,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, size: 40),
                                  SizedBox(height: 15),
                                  Text('Select your image', style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: Constants.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectTopics.contains(e)) {
                                      selectTopics.remove(e);
                                    } else {
                                      selectTopics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                      label: Text(e),
                                      color: selectTopics.contains(e) ? WidgetStatePropertyAll(AppPallete.gradient1) : null,
                                      side: BorderSide(
                                        color: AppPallete.borderColor,
                                      )),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                  SizedBox(height: 20),
                  BlogEditorWidget(
                    controller: titleController,
                    hintText: 'Blog Title',
                  ),
                  SizedBox(height: 20),
                  BlogEditorWidget(
                    controller: contentController,
                    hintText: 'Blog Content',
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
