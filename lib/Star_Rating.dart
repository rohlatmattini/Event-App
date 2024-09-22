import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Star_Rating extends StatefulWidget{
  int initialRating;
bool ignore;

  Star_Rating(this.initialRating, this.ignore);


  @override
  State<Star_Rating>createState()=>Star_Rating1(initialRating,ignore);
}
class Star_Rating1 extends State<Star_Rating>{
  int initialRating;
  bool ignore;


  Star_Rating1(this.initialRating, this.ignore);

  onRatingUpdate(rating){
      setState(() {
        initialRating=rating.toInt();
        // widget.onRatingUpdate(rating.toInt());

      });
    }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating:initialRating.toDouble(),
            ignoreGestures: ignore,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 3),
            itemBuilder: (context,_)=>Icon(Icons.star,color: Colors.indigo,),
            onRatingUpdate: (rating){
            setState(() {
              initialRating=rating.toInt();
              // widget.onRatingUpdate(rating.toInt());
            });
            }
        )
      ],
    );
  }

}

