import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class PlayerPanel extends StatelessWidget {
  final String name;
  final int score;
  final int maxScore;
  final Color accent;
  final Color accentDim;
  final bool flipped;
  final bool isWinner;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PlayerPanel({
    super.key,
    required this.name,
    required this.score,
    required this.maxScore,
    required this.accent,
    required this.accentDim,
    required this.onIncrement,
    required this.onDecrement,
    this.flipped = false,
    this.isWinner = false,
  });

  bool get _isMatchPoint => maxScore > 1 && score == maxScore - 1 && !isWinner;

  @override
  Widget build(BuildContext context) {
    final content = _PanelContent(
      name: name,
      score: score,
      maxScore: maxScore,
      accent: accent,
      accentDim: accentDim,
      isMatchPoint: _isMatchPoint,
      isWinner: isWinner,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
    );

    if (!flipped) return content;
    return Transform.rotate(angle: math.pi, child: content);
  }
}

class _PanelContent extends StatelessWidget {
  final String name;
  final int score;
  final int maxScore;
  final Color accent;
  final Color accentDim;
  final bool isMatchPoint;
  final bool isWinner;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _PanelContent({
    required this.name,
    required this.score,
    required this.maxScore,
    required this.accent,
    required this.accentDim,
    required this.isMatchPoint,
    required this.isWinner,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        maxScore == 0 ? 0.0 : (score / maxScore).clamp(0.0, 1.0).toDouble();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.mediumImpact();
        onIncrement();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [accentDim.withValues(alpha: 0.55), accentDim.withValues(alpha: 0.15)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: arenaLabelStyle(size: 22, color: accent, letterSpacing: 3),
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => ScaleTransition(
                    scale: anim,
                    child: FadeTransition(opacity: anim, child: child),
                  ),
                  child: Text(
                    '$score',
                    key: ValueKey(score),
                    style: scoreDigitStyle(
                      size: 108,
                      color: isWinner ? AppColors.win : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 22,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isMatchPoint ? 1 : 0,
                    child: Text(
                      'MATCH POINT',
                      style: arenaLabelStyle(size: 16, color: AppColors.gold, letterSpacing: 3),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 18,
              child: Material(
                color: Colors.black.withValues(alpha: 0.25),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onDecrement();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.remove, color: AppColors.textMuted, size: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
