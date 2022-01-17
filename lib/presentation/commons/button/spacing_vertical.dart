import 'package:flutter/material.dart';

class SpacingVerticalStream extends StatelessWidget {
  final Stream<dynamic> stream;
  final double errorVertical;
  final double spacingVertical;

  const SpacingVerticalStream({
    Key? key,
    required this.stream,
    this.errorVertical = 0.010,
    this.spacingVertical = 0.02,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.error != null) {
          return SizedBox(height: size.height * errorVertical);
        }

        return SizedBox(height: size.height * spacingVertical);
      },
    );
  }
}
