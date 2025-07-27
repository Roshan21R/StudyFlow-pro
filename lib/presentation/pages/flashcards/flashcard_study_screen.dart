import 'package:flutter/material.dart';

class FlashcardStudyScreen extends StatelessWidget {
  
  final String setId;
  
  
  const FlashcardStudyScreen({
    Key? key,
    
    required this.setId,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Study')),
      body: const Center(child: Text('FlashcardStudy - Coming Soon!')),
    );
  }
}
