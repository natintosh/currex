import 'package:flutter/material.dart';

class SettingsCategory extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsCategory({Key key, this.title = '', this.tiles = const []})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Ink(
            color: Colors.white,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return tiles[index];
              },
              itemCount: tiles.length,
            ),
          ),
        ],
      ),
    );
  }
}
