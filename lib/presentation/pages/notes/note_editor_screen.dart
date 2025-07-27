import 'package:flutter/material.dart';

class NoteEditorScreen extends StatelessWidget {
  
  
  final String? noteId;
  
  const NoteEditorScreen({
    Key? key,
    
    
    this.noteId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note Editor')),
      body: const Center(child: Text('NoteEditor - Coming Soon!')),
    );
  }
}
