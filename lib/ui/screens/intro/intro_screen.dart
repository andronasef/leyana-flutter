import 'package:flutter/material.dart';
import 'package:leyana/services/managers/settings_manager.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _isMale = true;
  final TextEditingController _nameField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(image: AssetImage('assets/images/hello.png')),
                const SizedBox(height: 8),
                Text(
                  "اهلا بيك!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "اهلا بيك في ابليكشن ليا انا او في الحقيقة هو ليك انت ده المكان اللي بتصلي وبتفتكر في انه الله عمل حاجات كتيير جميلة علشانك\nهنا بنشجعك انك تعيش الكلمة وتكون ليك انت 💖.\nبس قبل ما لازم ندخل البيانات اللي تحت دي!\nشكرا واتمنالك رحله جميلة 🚀",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(height: 1.35),
                ),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: TextField(
                    controller: _nameField,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'ادخل اسمك الاول',
                      labelText: 'اسمك',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // icon of name
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
                        value: false,
                        label: Text('بنت'),
                        icon: Icon(Icons.girl)),
                  ],
                  selected: <bool>{_isMale},
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () async {
                    // Save the name and gender to the database
                    try {
                      if (_nameField.text.isEmpty) {
                        return;
                      }
                      await SettingsManager.setSetting(
                          SettingName.name, _nameField.text.trim());
                      await SettingsManager.setSetting(
                          SettingName.isMale, _isMale.toString());
                      await SettingsManager.setSetting(
                          SettingName.userUniqueNumber,
                          DateTime.now().toString());
                      await SettingsManager.setSetting(
                          SettingName.userUniqueNumber,
                          DateTime.now().microsecond.toString());
                    } on Exception catch (e) {
                      // TODO
                    }

                    await SettingsManager.setSetting(
                        SettingName.isIntroDone, "true");

                    Navigator.of(context).popAndPushNamed("/");
                  },
                  child: const Text("اتفضل"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
