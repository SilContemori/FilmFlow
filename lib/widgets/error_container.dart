import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, required this.snapshot});
  final AsyncSnapshot<dynamic> snapshot;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
              children: [
                TextSpan(
                    text: snapshot.error
                        .toString()
                        .substring(0, snapshot.error.toString().length % 2)),
                const TextSpan(text: '\n'),
                TextSpan(
                    text: snapshot.error
                        .toString()
                        .substring(snapshot.error.toString().length % 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
