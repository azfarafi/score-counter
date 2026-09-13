import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WinOverlay extends StatelessWidget {
  final String winnerName;
  final Color accent;
  final int score1;
  final int score2;
  final VoidCallback onRematch;
  final VoidCallback onNewSettings;

  const WinOverlay({
    super.key,
    required this.winnerName,
    required this.accent,
    required this.score1,
    required this.score2,
    required this.onRematch,
    required this.onNewSettings,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0).toDouble(),
          child: Transform.scale(scale: 0.85 + (0.15 * value), child: child),
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Container(
          color: Colors.black.withOpacity(0.82),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.emoji_events, color: accent, size: 72),
                    const SizedBox(height: 16),
                    Text(
                      '$winnerName MENANG!',
                      textAlign: TextAlign.center,
                      style: arenaLabelStyle(size: 34, color: accent, letterSpacing: 3),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$score1 — $score2',
                      style: scoreDigitStyle(size: 40, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onRematch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'MAIN LAGI',
                          style: arenaLabelStyle(
                            size: 18,
                            color: AppColors.background,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: onNewSettings,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.surfaceLine),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'PENGATURAN BARU',
                          style: arenaLabelStyle(
                            size: 16,
                            color: AppColors.textPrimary,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
