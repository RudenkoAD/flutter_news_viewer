import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter News App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the news page
              },
              child: const Text('Go to News'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the settings page
              },
              child: const Text('Go to Settings'),
            ),
            const SizedBox(height: 16),
            Switch(
              value: false, // Replace with your theme switch value
              onChanged: (value) {
                // Handle theme switch
              },
            ),
          ],
        ),
      ),
    );
  }
}