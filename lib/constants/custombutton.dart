import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/constants/color.dart';
import 'package:machinetestnoviindus/constants/textsize.dart';
class SelectionButton extends StatelessWidget {
  // final String? iconPath; // Path to image asset
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionButton({
    super.key,
    // this.iconPath,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.darkred.withOpacity(0.8)
              : AppColors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.redcolor
                : AppColors.white.withOpacity(0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (isSelected && iconPath != null) ...[
            //   Image.asset(
            //     iconPath!,
            //     width: 20,
            //     height: 20,
            //     color: Colors.white,
            //   ),
            //   const SizedBox(width: 8),
            // ],
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: AppTextsize.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CustomTextButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkred : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.darkred,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppTextsize.bodyMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
