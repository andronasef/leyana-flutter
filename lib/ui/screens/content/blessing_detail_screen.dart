import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:leyana/models/blessing_db_model.dart';
import 'package:leyana/services/managers/blessings_manager.dart';
import 'package:leyana/utils/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BlessingDetailScreen extends StatelessWidget {
  const BlessingDetailScreen({
    super.key,
    required this.blessingId,
  });

  final String blessingId;

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
              future: BlessingsManager.getBlessing(blessingId),
              builder: (context, AsyncSnapshot<BlessingDBModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return const Center(child: Text('حدث خطأ ما'));
                }

                final BlessingDBModel blessing = snapshot.data!;

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
                              blessing.name,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () => _onShare(
                                    "${blessing.name}\n${blessing.meaning}\n\n${blessing.content}"),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () => _onCopy(context,
                                    "${blessing.name}\n${blessing.meaning}\n\n${blessing.content}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Markdown(
                        data: blessing.content,
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
