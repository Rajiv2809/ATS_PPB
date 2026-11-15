import 'package:flutter/material.dart';

import '../app_scope.dart';
import '../widgets/screen_components.dart';

const _muted = Color(0xff7c8078);

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  bool _draftRestored = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_draftRestored) {
      _noteController.text = AppScope.of(context).journalDraft;
      _draftRestored = true;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!AppScope.of(context).addJournalEntry()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali catatanmu.')),
      );
      return;
    }
    _noteController.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan rasa berhasil disimpan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Jurnal rasa')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          const Text(
            'Simpan kenangan di setiap suapan.',
            style: TextStyle(color: _muted, fontSize: 14),
          ),
          const SizedBox(height: 17),
          Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: BorderSide(color: Colors.black.withValues(alpha: .05)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catatan baru',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      key: const ValueKey('journal-food'),
                      initialValue: state.journalFoodId,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Kuliner',
                        prefixIcon: Icon(Icons.restaurant_outlined),
                      ),
                      items: [
                        for (final food in state.foods)
                          DropdownMenuItem(
                            value: food.id,
                            child: Text(
                              '${food.emoji}  ${food.name} · ${food.region}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (foodId) {
                        if (foodId != null) state.selectJournalFood(foodId);
                      },
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      key: const ValueKey('journal-note'),
                      controller: _noteController,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 200,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Bagaimana rasanya?',
                        hintText: 'Ceritakan rasa, suasana, atau kenangannya…',
                      ),
                      onChanged: state.updateJournalDraft,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Catatan belum boleh kosong.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      height: 49,
                      child: FilledButton.icon(
                        key: const ValueKey('save-journal-entry'),
                        onPressed: _saveEntry,
                        icon: const Icon(Icons.bookmark_add_outlined),
                        label: const Text('Simpan catatan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          SectionHeading(
            title: 'Kenangan tersimpan',
            subtitle: '${state.entries.length} catatan rasa',
          ),
          const SizedBox(height: 12),
          if (state.entries.isEmpty)
            const EmptyState(
              icon: Icons.menu_book_outlined,
              title: 'Jurnalmu masih kosong',
              message: 'Coba menu lokal dan catat ceritamu di sini.',
            )
          else
            for (final entry in state.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: JournalEntryCard(
                  entry: entry,
                  food: state.foodForEntry(entry),
                ),
              ),
        ],
      ),
    );
  }
}
