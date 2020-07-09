import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/rating.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.subtitle,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: thumbnail,
              ),
              Expanded(
                flex: 3,
                child: VideoDescription(
                  title: title,
                  subtitle: subtitle,
                ),
              ),
              const Icon(
                Icons.more_vert,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14.0, color: Colors.white54),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          RatingWidget()
        ],
      ),
    );
  }
}
