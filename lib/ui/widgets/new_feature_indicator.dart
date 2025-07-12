import 'package:flutter/material.dart';

class NewFeatureIndicator extends StatefulWidget {
  final Widget child;
  final bool showIndicator;
  final String? tooltipMessage;

  const NewFeatureIndicator({
    super.key,
    required this.child,
    required this.showIndicator,
    this.tooltipMessage,
  });

  @override
  State<NewFeatureIndicator> createState() => _NewFeatureIndicatorState();
}

class _NewFeatureIndicatorState extends State<NewFeatureIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // إعداد animation للpulse effect
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // بداية الanimation لو الindicator مفعل
    if (widget.showIndicator) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(NewFeatureIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // تحديث الanimation عند تغيير showIndicator
    if (widget.showIndicator && !oldWidget.showIndicator) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.showIndicator && oldWidget.showIndicator) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showIndicator) {
      return widget.child;
    }

    Widget indicatorWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned(
          top: -6,
          right: -6,
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.6),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    // إضافة tooltip لو متوفر
    if (widget.tooltipMessage != null) {
      return Tooltip(
        message: widget.tooltipMessage!,
        child: indicatorWidget,
      );
    }

    return indicatorWidget;
  }
}
