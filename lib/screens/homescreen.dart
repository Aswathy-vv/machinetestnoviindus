import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/constants/color.dart';
import 'package:machinetestnoviindus/constants/custombutton.dart';
import 'package:machinetestnoviindus/constants/textsize.dart';
import 'package:machinetestnoviindus/provider/homeprovider.dart';
import 'package:machinetestnoviindus/screens/addfeed.dart';
import 'package:machinetestnoviindus/screens/myfeed.dart';
import 'package:machinetestnoviindus/screens/videocontroller.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  String _timeAgo(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) return "";

    try {
      final created = DateTime.parse(createdAt);
      final now = DateTime.now();
      final diff = now.difference(created);

      if (diff.inSeconds < 60) {
        return "just now";
      } else if (diff.inMinutes < 60) {
        return "${diff.inMinutes} min${diff.inMinutes > 1 ? 's' : ''} ago";
      } else if (diff.inHours < 24) {
        return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
      } else if (diff.inDays < 7) {
        return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
      } else if (diff.inDays < 30) {
        final weeks = (diff.inDays / 7).floor();
        return "$weeks week${weeks > 1 ? 's' : ''} ago";
      } else if (diff.inDays < 365) {
        final months = (diff.inDays / 30).floor();
        return "$months month${months > 1 ? 's' : ''} ago";
      } else {
        final years = (diff.inDays / 365).floor();
        return "$years year${years > 1 ? 's' : ''} ago";
      }
    } catch (e) {
      return "";
    }
  }

  final List<Map<String, dynamic>> buttons = [
    {"icon": Icons.explore, "text": "Explore"},
    {"icon": Icons.trending_down, "text": "Trending"},
    {"icon": Icons.category, "text": "All Categories"},
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).fetchCategoryData();

    Provider.of<HomeProvider>(context, listen: false).fetchBannerData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.redcolor,
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addfeed()));
          }),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              color: AppColors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello Maria",
                        style: TextStyle(color: AppColors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Myfeed()));
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.peach,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Welcome back to Section",
                    style: TextStyle(color: AppColors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        final List categories =
                            provider.bannerData?["categories"] ?? [];
                        if (categories!.isEmpty) {
                          return const Text(
                            "No categories available",
                            style: TextStyle(color: Colors.grey),
                          );
                        }
                        return provider != null
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        categories.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: SelectionButton(
                                                text: categories[index]
                                                    ["title"],
                                               
                                                isSelected:
                                                    selectedIndex == index,
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                },
                                              ),
                                            ))))
                            : SizedBox();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      final results = provider.categoryData?["results"];

                      if (results == null || results.isEmpty) {
                        return const Center(
                          child: Text(
                            "No content available",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];
                          final user = item["user"];
                          final userName = user?["name"] ?? "Unknown User";
                          final createdAt = item["created_at"] ?? "";
                          final description = item["description"] ?? "";
                          final imageUrl = item["image"] ??
                              "https://cdn.pixabay.com/photo/2016/11/21/06/53/beautiful-natural-image-1844362_640.jpg";

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// User Info Row
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.pinkAccent,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                        Text(
                                          _timeAgo(createdAt),
                                          style: TextStyle(
                                            color: AppColors.white
                                                .withOpacity(0.6),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                StyledVideoContainer(videoUrl: item["video"]),

                                

                                const SizedBox(height: 10),

                                Text(
                                  description,
                                  style: TextStyle(
                                      color: AppColors.white.withOpacity(0.8),
                                      fontSize: AppTextsize.bodySmall),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
