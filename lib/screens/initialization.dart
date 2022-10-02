import 'package:flutter/material.dart';
import '../widgets/loading.dart';

class Initialization extends StatelessWidget {
  final dynamic initialization;
  final String route;

  Initialization(this.initialization, this.route);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('SUCCESSFULLY CONNECTED TO FIREBASE!');

          Future.delayed(Duration.zero, () {
            Navigator.pushNamed(context, route);
          });
        }
        return const Scaffold(
          body: LoadingWidget(),
        );
      },
    );
  }
}
