import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leyana/bloc/cubit/blessing/blessing_cubit.dart';
import 'package:leyana/bloc/cubit/god_name/god_name_cubit.dart';
import 'package:leyana/bloc/cubit/verse/verse_cubit.dart';
import 'package:animations/animations.dart';
import 'package:leyana/types/content_type.dart';
import 'package:leyana/ui/widgets/blessing.dart';
import 'package:leyana/ui/widgets/verse.dart';
import 'package:leyana/ui/widgets/god_name.dart';
import 'package:leyana/ui/widgets/new_feature_indicator.dart';
import 'package:leyana/ui/widgets/blessings_indicator_debug_info.dart';
import 'package:leyana/services/blessings_indicator_service.dart';
import 'package:leyana/core/values.dart';
import 'package:leyana/utils/snackbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ContentType _selectedType = ContentType.verse;
  bool _showBlessingsIndicator = false;

  @override
  void initState() {
    super.initState();
    _checkBlessingsIndicator();
  }

  Future<void> _checkBlessingsIndicator() async {
    final bool shouldShow =
        await BlessingsIndicatorService.shouldShowIndicator();
    if (mounted) {
      setState(() {
        _showBlessingsIndicator = shouldShow;
      });
    }
  }

  void _onContentTypeSelected(ContentType type) {
    setState(() {
      _selectedType = type;
    });

    // لو اختار البركات الروحية لأول مرة، يسجل ده
    if (type == ContentType.blessing && _showBlessingsIndicator) {
      BlessingsIndicatorService.markBlessingsAsSeen().then((_) {
        _checkBlessingsIndicator(); // إعادة تحديث الindicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (
                Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey(_selectedType), // Add key here
                child: _buildContentWidget(),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ContentType.values.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: NewFeatureIndicator(
                    showIndicator:
                        type == ContentType.blessing && _showBlessingsIndicator,
                    tooltipMessage:
                        type == ContentType.blessing && _showBlessingsIndicator
                            ? '🌟 ميزة جديدة! اكتشف البركات الروحية الملهمة'
                            : null,
                    child: FilterChip(
                      selected: _selectedType == type,
                      label: Text(type.label),
                      onSelected: (selected) {
                        _onContentTypeSelected(type);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildContentWidget() {
    if (_selectedType == ContentType.verse) {
      return BlocConsumer<VerseCubit, VerseState>(
        builder: (context, state) {
          if (state is VerseLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VerseLoaded) {
            return Column(
              children: [
                // Debug info في debug mode بس
                if (kDebugMode && Config.kTestingBlessingsIndicator)
                  const BlessingsIndicatorDebugInfo(),
                // Debug button في debug mode بس
                if (kDebugMode && Config.kTestingBlessingsIndicator)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await BlessingsIndicatorService.resetIndicator();
                        _checkBlessingsIndicator();
                        if (mounted) {
                          showSnackbar(context, 'تم إعادة تعيين مؤشر البركات');
                        }
                      },
                      child: const Text('إعادة تعيين مؤشر البركات (Debug)'),
                    ),
                  ),
                Expanded(
                  child: Verse(
                    verseModel: state.randomVerse,
                    isFavoriteList: false,
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('حدث خطأ ما'));
        },
        listener: (context, state) {
          if (state is VerseError) {
            showSnackbar(context, state.message);
          }
        },
      );
    } else if (_selectedType == ContentType.godName) {
      return BlocConsumer<GodNameCubit, GodNameState>(
        builder: (context, state) {
          if (state is GodNameLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GodNameLoaded) {
            return GodName(
              godNameModel: state.godName,
            );
          }
          return const Center(child: Text('حدث خطأ ما'));
        },
        listener: (context, state) {
          if (state is GodNameError) {
            showSnackbar(context, state.message);
          }
        },
      );
    } else if (_selectedType == ContentType.blessing) {
      return BlocConsumer<BlessingCubit, BlessingState>(
        builder: (context, state) {
          if (state is BlessingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BlessingLoaded) {
            return Blessing(
              blessingModel: state.blessing,
            );
          }
          return const Center(child: Text('حدث خطأ ما'));
        },
        listener: (context, state) {
          if (state is BlessingError) {
            showSnackbar(context, state.message);
          }
        },
      );
    } else {
      return const Center(child: Text('قريباً'));
    }
  }
}
