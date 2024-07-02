import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String _selectedGender = "ولد";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage('assets/images/hello.png')),
              SizedBox(height: 8),
              Text(
                "اهلا بيك!",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "اهلا بيك في ابليكشن ليا انا او في الحقيقة هو ليك انت ده المكان اللي بتصلي وبتفتكر في انه الله عمل حاجات كتيير جميلة علشانك\nهنا بنشجعك انك تعيش الكلمة وتكون ليك انت 💖.\nبس قبل ما لازم ندخل البيانات اللي تحت دي!\nشكرا واتمنالك رحله جميلة 🚀",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.35),
              ),
              SizedBox(height: 32),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'ادخل اسمك',
                    labelText: 'اسمك',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // icon of name
                ),
              ),
              SizedBox(height: 16),
              SegmentedButton<String>(
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _selectedGender = newSelection.first;
                  });
                },
                showSelectedIcon: true,
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                      value: "ولد", label: Text('ولد'), icon: Icon(Icons.boy)),
                  ButtonSegment<String>(
                      value: "بنت", label: Text('بنت'), icon: Icon(Icons.girl)),
                ],
                selected: <String>{_selectedGender},
              ),
              SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
                child: Text("اتفضل"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
