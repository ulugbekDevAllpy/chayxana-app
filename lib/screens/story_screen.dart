import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../theme/app_theme.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key, required this.initialIndex});
  final int initialIndex;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with TickerProviderStateMixin {
  static const _storyDuration = Duration(seconds: 6);

  late final PageController _pageController;
  late int _currentIndex;
  late AnimationController _progressController;
  Timer? _advanceTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _progressController = AnimationController(vsync: this, duration: _storyDuration);
    _startStory();
  }

  void _startStory() {
    _progressController
      ..reset()
      ..forward();
    _advanceTimer?.cancel();
    _advanceTimer = Timer(_storyDuration, _next);
  }

  void _next() {
    if (_currentIndex < stories.length - 1) {
      _currentIndex += 1;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      _startStory();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      _currentIndex -= 1;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      _startStory();
    } else {
      _startStory();
    }
  }

  void _pause() {
    _progressController.stop();
    _advanceTimer?.cancel();
  }

  void _resume() {
    final remaining = _storyDuration * (1 - _progressController.value);
    _progressController.forward();
    _advanceTimer = Timer(remaining, _next);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    _advanceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stories.length,
          itemBuilder: (context, i) => _StoryView(story: stories[i]),
        ),
      ),
      extendBody: true,
    );
  }
}

class _StoryView extends StatelessWidget {
  const _StoryView({required this.story});
  final StoryCard story;

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_StoryScreenState>()!;

    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: story.coverUrl,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(color: Colors.black),
            errorWidget: (_, _, _) => Container(color: Colors.black),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: state._previous,
                onLongPressStart: (_) => state._pause(),
                onLongPressEnd: (_) => state._resume(),
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: state._next,
                onLongPressStart: (_) => state._pause(),
                onLongPressEnd: (_) => state._resume(),
              ),
            ),
          ],
        ),
        Positioned(
          left: 12,
          right: 12,
          top: 12,
          child: Column(
            children: [
              _ProgressBars(
                count: stories.length,
                currentIndex: state._currentIndex,
                controller: state._progressController,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                story.headline,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                story.body,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined, color: Colors.white, size: 18),
                  label: Text(
                    story.ctaLabel,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressBars extends StatelessWidget {
  const _ProgressBars({
    required this.count,
    required this.currentIndex,
    required this.controller,
  });

  final int count;
  final int currentIndex;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          children: [
            for (var i = 0; i < count; i++) ...[
              Expanded(
                child: _ProgressBar(
                  fill: i < currentIndex
                      ? 1.0
                      : i == currentIndex
                          ? controller.value
                          : 0.0,
                ),
              ),
              if (i < count - 1) const SizedBox(width: 4),
            ],
          ],
        );
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.fill});
  final double fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: fill.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
