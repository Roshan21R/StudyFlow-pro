import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;
  
  
  
  const TaskDetailScreen({
    Key? key,
    required this.taskId,
    
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Detail')),
      body: const Center(child: Text('TaskDetail - Coming Soon!')),
    );
  }
}
