import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';

class PaginatedLoading extends StatelessWidget {
  const PaginatedLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingWidget(),
            SizedBox(width: 10),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
