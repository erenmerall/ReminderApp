import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../widgets/reminder_category_grid.dart';
import 'add_reminder_page.dart';

class HomePage extends StatefulWidget {
  final String pageTitle = "Reminders";
  final int titleFontSize = 24;
  final FontWeight titleFontWeight = FontWeight.bold;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReminderProvider>();

    final pages = [
      ReminderCategoryGrid(list: provider.active),
      ReminderCategoryGrid(list: provider.completed),
      ReminderCategoryGrid(list: provider.deleted),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: TextStyle(
            fontSize: widget.titleFontSize.toDouble(),
            fontWeight: widget.titleFontWeight,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => setState(() => index = 0),
          ),
        ),
      ),
      body: pages[index],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddReminderPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => setState(() => index = 1),
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(() => index = 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
