import 'package:flutter/material.dart';

class AddCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pending),
          Text('Add today\'s story'.toUpperCase()),
        ],
      ),
    );
  }
}
