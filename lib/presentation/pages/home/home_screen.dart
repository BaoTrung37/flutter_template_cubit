import 'package:auto_route/auto_route.dart';
import 'package:example_flutter_app/presentation/presentation.dart';
import 'package:example_flutter_app/presentation/widgets/caroulse_slider/custom_carousel_slider.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              context.localizations.appName,
            ),
            const CustomCarouselSlider(),
          ],
        ),
      ),
    );
  }
}
