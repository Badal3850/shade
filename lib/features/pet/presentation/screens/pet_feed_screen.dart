import 'package:flutter/material.dart';
import 'package:shade/features/pet/presentation/widgets/post_card.dart';

class PetFeedScreen extends StatelessWidget {
  const PetFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STORY FEED'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: 5, // Simulated history
        itemBuilder: (context, index) {
          return const PostCard();
        },
      ),
    );
  }
}
