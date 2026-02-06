import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';
import '../../core/constants/categories.dart';
import '../providers/reminder_provider.dart';
import '../widgets/title_textfield.dart';

class AddReminderPage extends StatefulWidget {
  final String pageTitle = "New Reminder";
  final int titleFontSize = 24;
  final FontWeight titleFontWeight = FontWeight.bold;
  final String categoriesTitle = "Categories";
  final String dateTitle = "Date";
  final String timeTitle = "Time";
  final double subTitlesFontSize = 16;
  final FontWeight subTitleFontWeight = FontWeight.w500;

  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final TextEditingController titleController = TextEditingController();

  DateTime selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
  String selectedCategory = categories.first.name;

  Color getCategoryColor() {
    return categories.firstWhere((c) => c.name == selectedCategory).color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.pageTitle,
          style: TextStyle(
            fontSize: widget.titleFontSize.toDouble(),
            fontWeight: widget.titleFontWeight,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            /// Title
            ReminderTitleTextField(titleController: titleController),

            const SizedBox(height: 24),

            /// Category Chips
            Text(
              widget.categoriesTitle,
              style: TextStyle(
                fontSize: widget.subTitlesFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            CategoriesChips(),

            const SizedBox(height: 30),

            /// Date Picker inline
            Text(
              widget.dateTitle,
              style: TextStyle(
                fontSize: widget.subTitlesFontSize,
                fontWeight: widget.subTitleFontWeight,
              ),
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: getCategoryColor(), // seçili kategori rengi
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: getCategoryColor(),
                  ),
                ),
              ),
              child: CalendarDatePicker(
                initialDate: selectedDateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                onDateChanged: (date) {
                  setState(() {
                    selectedDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      selectedDateTime.hour,
                      selectedDateTime.minute,
                    );
                  });
                },
              ),
            ),

            /// Time Picker inline
            Text(
              widget.timeTitle,
              style: TextStyle(
                fontSize: widget.subTitlesFontSize,
                fontWeight: widget.subTitleFontWeight,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: TimePickerSpinner(
                time: selectedDateTime,
                is24HourMode: true,
                normalTextStyle: const TextStyle(fontSize: 16),
                highlightedTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                spacing: 30,
                itemHeight: 50,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    selectedDateTime = DateTime(
                      selectedDateTime.year,
                      selectedDateTime.month,
                      selectedDateTime.day,
                      time.hour,
                      time.minute,
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            /// Save Button
            SaveButton(),
          ],
        ),
      ),
    );
  }

  ElevatedButton SaveButton() {
    final color = getCategoryColor();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.20),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: saveReminder,
      child: const Text(
        "Save Reminder",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
      ),
    );
  }

  Wrap CategoriesChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((cat) {
        final isSelected = selectedCategory == cat.name;

        return ChoiceChip(
          avatar: Icon(cat.icon, size: 18, color: cat.color),
          label: Text(cat.name),
          selected: isSelected,
          selectedColor: cat.color.withOpacity(0.2),
          onSelected: (_) {
            setState(() {
              selectedCategory = cat.name;
            });
          },
        );
      }).toList(),
    );
  }

  void saveReminder() {
    if (titleController.text.trim().isEmpty) return;

    context.read<ReminderProvider>().addReminder(
      titleController.text.trim(),
      selectedDateTime,
      selectedCategory,
    );

    Navigator.pop(context);
  }
}
