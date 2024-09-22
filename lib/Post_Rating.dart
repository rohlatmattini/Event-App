import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Post_Rating extends StatefulWidget {
  final double initialRating;
  final bool ignore;
  final Function(double rating) onRatingChanged; // Add this function

  Post_Rating(this.initialRating, this.ignore, this.onRatingChanged);

  @override
  State<Post_Rating> createState() => Post_RatingState();
}

class Post_RatingState extends State<Post_Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: widget.initialRating.toDouble(),
          ignoreGestures: widget.ignore,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 3),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.indigo),
          onRatingUpdate: (rating) {
            widget.onRatingChanged(rating.toDouble()); // Call the provided function
          },
        )
      ],
    );
  }
}
