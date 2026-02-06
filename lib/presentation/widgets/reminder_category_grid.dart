import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/categories.dart';
import '../../data/models/reminder_model.dart';
import '../providers/reminder_provider.dart';
import 'reminder_card.dart';

class ReminderCategoryGrid extends StatelessWidget {
  final List<ReminderModel> list;

  const ReminderCategoryGrid({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReminderProvider>();

    final pinned = list.where((r) => r.isPinned).toList();

    final byCategory = <String, List<ReminderModel>>{};
    for (var r in list.where((r) => !r.isPinned)) {
      byCategory.putIfAbsent(r.category, () => []).add(r);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pinned.isNotEmpty) ...[
          const Text(
            "📌 Pinned",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildGrid(pinned, provider),
          const SizedBox(height: 24),
        ],
        ...byCategory.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildGrid(entry.value, provider),
              const SizedBox(height: 24),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildGrid(List<ReminderModel> list, ReminderProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final r = list[index];
        final cat = categories.firstWhere((c) => c.name == r.category);

        return ReminderCard(
          reminder: r,
          category: cat,
          onPin: () => provider.togglePin(r),
        );
      },
    );
  }
}
