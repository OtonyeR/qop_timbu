import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Error message widget
class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage('assets/error.png'),
          ),
          const SizedBox(height: 24),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                message,
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 18),
          Text(
            'Swipe Down to Refresh',
          ),
        ],
      ),
    );
  }
}
