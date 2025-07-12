import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:leyana/models/god_name_db_model.dart';
import 'package:leyana/services/managers/god_names_manager.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GodNameDetailScreen extends StatelessWidget {
  const GodNameDetailScreen({
    super.key,
    required this.nameId,
  });

  final String nameId;

  void _onShare(String content) {
    Share.share(content);
  }

  void _onCopy(BuildContext context, String content) {
    Clipboard.setData(ClipboardData(text: content));
    showSnackbar(context, "تم النسخ");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: GodNamesManager.getGodName(nameId),
              builder: (context, AsyncSnapshot<GodNameDBModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return const Center(child: Text('حدث خطأ ما'));
                }

                final GodNameDBModel godName = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => context.pop(),
                          ),
                          Flexible(
                            child: Text(
                              godName.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () => _onShare(
                                    "${godName.name}\n${godName.meaning}\n\n${godName.content}"),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () => _onCopy(context,
                                    "${godName.name}\n${godName.meaning}\n\n${godName.content}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Markdown(
                        data: godName.content,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
