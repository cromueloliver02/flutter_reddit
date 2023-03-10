import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RDTElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool loading;
  final bool isBlock;

  const RDTElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.isBlock = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: !loading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: isBlock ? const Size(double.infinity, 50) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.bodyLarge,
          ),
          if (loading) ...[
            const SizedBox(width: 10),
            const SizedBox.square(
              dimension: 25,
              child: SpinKitRing(
                color: Colors.white,
                lineWidth: 3,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
