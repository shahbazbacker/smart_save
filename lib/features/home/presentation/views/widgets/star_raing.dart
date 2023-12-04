import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.itemSize,
    required this.rating,
    this.ignoreGesture,
  });

  final double rating;
  final double itemSize;
  final bool? ignoreGesture;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      tapOnlyMode: true,
      ignoreGestures: ignoreGesture ?? false,
      itemSize: itemSize,
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.deepOrange,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
