import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/constants/color.dart';
import 'package:machinetestnoviindus/constants/textsize.dart';
import 'package:machinetestnoviindus/provider/addfeedprovider.dart';
import 'package:machinetestnoviindus/screens/videocontroller.dart';
import 'package:provider/provider.dart';

class Myfeed extends StatefulWidget {
  const Myfeed({super.key});

  @override
  State<Myfeed> createState() => _MyfeedState();
}

class _MyfeedState extends State<Myfeed> {
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

  @override
  void initState() {
    super.initState();
    Provider.of<Addfeedprovider>(context, listen: false).fetchfeedData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                  Container(
                    child: Text(
                      "Share Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppTextsize.bodyMedium,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.darkred.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.redcolor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<Addfeedprovider>(
                builder: (context, provider, child) {
                  final results = provider.feedData?["results"];

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    Text(
                                      _timeAgo(createdAt),
                                      style: TextStyle(
                                        color: AppColors.white.withOpacity(0.6),
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
    );
  }
}
