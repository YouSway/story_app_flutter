import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/pages/story_page.dart';
import 'package:flutter_story_app/utils/constants.dart';
import 'package:flutter_story_app/utils/theme.dart';

class CardFav extends StatefulWidget {
  final Story story;

  const CardFav({Key key, this.story}) : super(key: key);

  @override
  _CardFavState createState() => _CardFavState();
}

class _CardFavState extends State<CardFav> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(_createRoute(widget.story));
        },
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: <Widget>[
                FadeInImage(
                  image:
                      NetworkImage(THUMBNAILS_BASE_URL + widget.story.images),
                  placeholder: AssetImage("assets/black.jpg"),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: mediaQuery.size.width / 2.5,
                ),
                Container(
                  width: double.infinity,
                  height: mediaQuery.size.width / 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Color(0xFF1b1e44),
                          Color(0x001b1e44),
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.story.title,
                              style: CustomTheme.mainTheme.textTheme.title.merge(TextStyle(fontSize: 20)),
                              maxLines: 2,
                            ),
                            Text(
                              "by " + widget.story.author,
                              style: CustomTheme.mainTheme.textTheme.body1,
                              maxLines: 2,
                            ),
//                            SingleChildScrollView(
//                              scrollDirection: Axis.horizontal,
//                              child: StoryChips(strTags: widget.story.tags),
//                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute(Story story) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => StoryPage(
        story: story,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CircularRevealAnimation(
          child: child,
          animation: animation,
          centerAlignment: Alignment.center,
        );
      },
    );
  }
}
