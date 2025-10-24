import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machinetestnoviindus/constants/color.dart';
import 'package:machinetestnoviindus/constants/custombutton.dart';
import 'package:machinetestnoviindus/constants/textsize.dart';
import 'package:machinetestnoviindus/main.dart';
import 'package:machinetestnoviindus/provider/addfeedprovider.dart';
import 'package:machinetestnoviindus/provider/homeprovider.dart';
import 'package:provider/provider.dart';

class Addfeed extends StatefulWidget {
  const Addfeed({super.key});

  @override
  State<Addfeed> createState() => _AddfeedState();
}

class _AddfeedState extends State<Addfeed> {
  int selectedIndex = 0;
  File? videoFile;
  File? imageFile;
  TextEditingController descController = TextEditingController();

  int selectedCategoryId = 0; // store category ID from API

  Future<void> pickVideo() async {
    final XFile? pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        videoFile = File(pickedVideo.path);
      });
    }
  }

// Image picker (thumbnail)
  Future<void> pickImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<HomeProvider>(context, listen: false).fetchCategoryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 20,
                      child: CircleAvatar(
                        backgroundColor: AppColors.black,
                        radius: 19,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text("Add feed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppTextsize.bodyMedium,
                        fontWeight: FontWeight.w500,
                      )),
                  InkWell(
                    onTap: () async {
                      if (videoFile == null ||
                          imageFile == null ||
                          descController.text.isEmpty) {
                        // Show error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please fill all fields")),
                        );
                        return;
                      }

                      try {
                        // Call your provider/API function
                        await context.read<Addfeedprovider>().addfeedprovider(
                          imageFile!.path, // Use .path instead of .toString()
                          videoFile!.path,
                          descController.text,
                          [selectedCategoryId],
                        );

                        // Optional: show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Feed added successfully")),
                        );

                        // Navigate back
                        Navigator.pop(context);
                      } catch (e) {
                        // Handle error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    },
                    child: Container(
                      child: Text(
                        "Share Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppTextsize.bodyMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.darkred.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.redcolor),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Video selection
              Center(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  dashPattern: [6, 3],
                  color: AppColors.white.withOpacity(0.4),
                  strokeWidth: 2,
                  child: InkWell(
                    onTap: pickVideo,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.center,
                      child: videoFile != null
                          ? Text(
                              "Video Selected",
                              style: TextStyle(color: Colors.white),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.video_collection_outlined,
                                  color: AppColors.white,
                                  size: 40,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Select a video from gallery",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppTextsize.bodyMedium),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Image selection
              Center(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  dashPattern: [6, 3],
                  color: AppColors.white.withOpacity(0.4),
                  strokeWidth: 2,
                  child: InkWell(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.center,
                      child: imageFile != null
                          ? Image.file(imageFile!, fit: BoxFit.cover)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: AppColors.white,
                                  size: 40,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Add thumbnail",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppTextsize.bodyMedium),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //
              SizedBox(
                height: 10,
              ),
              Text(
                "Add description",
                style: TextStyle(
                    color: Colors.white, fontSize: AppTextsize.bodyLarge),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descController,
                maxLines: 4, // allow multi-line description
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppTextsize.bodyMedium,
                ),
                decoration: InputDecoration(
                  hintText: "Add description here...",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: AppTextsize.bodyMedium,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.redcolor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories of this project",
                    style: TextStyle(
                        color: Colors.white, fontSize: AppTextsize.bodyLarge),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "view All ",
                    style: TextStyle(
                        color: Colors.white, fontSize: AppTextsize.bodyLarge),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 10,
                    child: CircleAvatar(
                      backgroundColor: AppColors.black,
                      radius: 9,
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 8,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return provider.bannerData != null
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 4,
                            ),
                            itemCount: provider
                                .categoryData!.length, // category list from API
                            itemBuilder: (context, index) {
                              return CustomTextButton(
                                text: provider.bannerData?["categories"][index]
                                    ["title"],
                                isSelected: selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedCategoryId = provider
                                        .bannerData?["categories"][index]["id"];
                                  });
                                },
                              );
                            },
                          )
                        : SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
