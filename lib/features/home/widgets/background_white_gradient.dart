import 'package:flutter/material.dart';

class BackgroundWhiteGradient extends StatelessWidget {
  const BackgroundWhiteGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.95),
            Colors.white,
          ],
          stops: const [0, 0.1, 0.4, 0.6],
        ),
      ),
    );
  }
}
