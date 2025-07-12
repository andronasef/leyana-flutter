import 'package:flutter/material.dart';
import 'package:leyana/core/values.dart';
import 'package:share_plus/share_plus.dart';
import 'package:leyana/services/share_popup_service.dart';

class ShareAppPopup extends StatelessWidget {
  const ShareAppPopup({super.key});

  void _shareApp() {
    const String shareText = '''
🌟 تطبيق "ليا أنا" - كلمة الله ليك أنت كل يوم 🌟

✨ اكتشف:
📖 آيات كتابية مُلهمة بتكلمك بشكل شخصي
🙏 وعود الله اللي بتشجعك وتقوي إيمانك
✝️ بركات سماوية تملأ قلبك بالسلام

حمّل التطبيق دلوقتي وابدأ رحلتك مع الكلمة! 🙏
${AppUrls.shareGooglePlay}

    ''';

    Share.share(shareText);
    // Mark app as shared to stop showing popup
    SharePopupService.markAppAsShared();
  }

  void _markAsPostponed() async {
    await SharePopupService.postponePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon مع تأثير جميل
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),

            // العنوان
            Text(
              '🌟 شكراً ليك! 🌟',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // النص الرئيسي
            Text(
              'مبسوطين انه الابلكيشن فارق معاك! ✨\nإيه رأيك تشارك البركة دي مع غيرك؟',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // نص إضافي مشجع
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
              child: Text(
                '💫 "فَلْيُضِئْ نُورُكُمْ هكَذَا قُدَّامَ النَّاسِ..." (متى 5: 16)\n\nمشاركتك للتطبيق ممكن تكون سبب بركة وتشجيع لشخص محتاج كلمة من ربنا 🙏',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                      height: 1.4,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // الأزرار
            Row(
              children: [
                // زر لاحقاً

                // زر المشاركة
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _shareApp();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                    ),
                    icon: const Icon(Icons.share, size: 20),
                    label: const Text(
                      'شارك التطبيق',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _markAsPostponed();
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('لاحقاً'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // نص صغير في الأسفل
          ],
        ),
      ),
    );
  }
}
