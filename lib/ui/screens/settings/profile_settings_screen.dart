import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leyana/services/managers/settings_manager.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final TextEditingController _nameField = TextEditingController();
  bool _isMale = true;

  @override
  void initState() {
    super.initState();
    _loadInitialValues();
  }

  Future<void> _loadInitialValues() async {
    final String? name = await SettingsManager.getSetting(SettingName.name);
    if (name != null) {
      _nameField.text = name;
    }

    final String? isMale = await SettingsManager.getSetting(SettingName.isMale);
    if (isMale != null) {
      setState(() {
        _isMale = isMale != "false";
      });
    }
  }

  void _onSavePressed() async {
    if (_nameField.text.isEmpty) return;

    await SettingsManager.setSetting(SettingName.name, _nameField.text.trim());
    await SettingsManager.setSetting(SettingName.isMale, _isMale.toString());

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => context.pop(),
                    ),
                    Text(
                      "معلومات شخصية",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: TextField(
                  controller: _nameField,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'ادخل اسمك',
                    labelText: 'اسمك',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SegmentedButton<bool>(
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() {
                    _isMale = newSelection.first;
                  });
                },
                showSelectedIcon: true,
                segments: const <ButtonSegment<bool>>[
                  ButtonSegment<bool>(
                      value: true, label: Text('ولد'), icon: Icon(Icons.boy)),
                  ButtonSegment<bool>(
                      value: false, label: Text('بنت'), icon: Icon(Icons.girl)),
                ],
                selected: <bool>{_isMale},
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _onSavePressed,
                child: const Text("حفظ"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
