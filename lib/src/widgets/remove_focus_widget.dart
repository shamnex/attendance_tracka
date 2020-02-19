import 'package:flutter/material.dart';

class RemoveFocusWidget extends StatelessWidget {
  final Widget child;

  const RemoveFocusWidget({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Clear focus of our fields when tapped in this empty space
          FocusScope.of(context).unfocus();
        },
        child: this.child);
  }
}
