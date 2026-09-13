import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/match_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/arena_background.dart';
import 'scoreboard_screen.dart';

const List<int> _presetScores = [11, 15, 21, 25];

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  int _maxScore = 21;

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  void _changeMaxScore(int delta) {
    setState(() {
      final next = _maxScore + delta;
      _maxScore = next.clamp(1, 999).toInt();
    });
    HapticFeedback.selectionClick();
  }

  void _startMatch() {
    FocusScope.of(context).unfocus();
    final settings = MatchSettings(
      player1Name: _player1Controller.text.trim().isEmpty
          ? 'PEMAIN 1'
          : _player1Controller.text.trim().toUpperCase(),
      player2Name: _player2Controller.text.trim().isEmpty
          ? 'PEMAIN 2'
          : _player2Controller.text.trim().toUpperCase(),
      maxScore: _maxScore,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScoreboardScreen(initialSettings: settings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArenaBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(),
                    const SizedBox(height: 36),
                    _PlayerNameField(
                      label: 'PEMAIN 1',
                      hint: 'Nama pemain 1',
                      accent: AppColors.playerOne,
                      controller: _player1Controller,
                    ),
                    const SizedBox(height: 16),
                    _PlayerNameField(
                      label: 'PEMAIN 2',
                      hint: 'Nama pemain 2',
                      accent: AppColors.playerTwo,
                      controller: _player2Controller,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'SKOR MAKSIMAL UNTUK MENANG',
                      textAlign: TextAlign.center,
                      style: arenaLabelStyle(
                        size: 15,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _MaxScoreStepper(
                      value: _maxScore,
                      onChanged: _changeMaxScore,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: _presetScores.map((preset) {
                        final selected = preset == _maxScore;
                        return ChoiceChip(
                          label: Text(
                            '$preset',
                            style: arenaLabelStyle(
                              size: 16,
                              color: selected
                                  ? AppColors.background
                                  : AppColors.textPrimary,
                              letterSpacing: 1,
                            ),
                          ),
                          selected: selected,
                          onSelected: (_) {
                            setState(() => _maxScore = preset);
                            HapticFeedback.selectionClick();
                          },
                          selectedColor: AppColors.gold,
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: AppColors.surfaceLine),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    _StartButton(onPressed: _startMatch),
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

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'ATUR PERTANDINGAN',
          textAlign: TextAlign.center,
          style: arenaLabelStyle(size: 32, color: AppColors.gold, letterSpacing: 4),
        ),
        const SizedBox(height: 6),
        Text(
          'Siapkan papan skor sebelum permainan dimulai',
          textAlign: TextAlign.center,
          style: arenaLabelStyle(size: 15, color: AppColors.textMuted, letterSpacing: 1),
        ),
      ],
    );
  }
}

class _PlayerNameField extends StatelessWidget {
  final String label;
  final String hint;
  final Color accent;
  final TextEditingController controller;

  const _PlayerNameField({
    required this.label,
    required this.hint,
    required this.accent,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 52,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.words,
            maxLength: 14,
            style: arenaLabelStyle(size: 20, color: AppColors.textPrimary, letterSpacing: 1),
            decoration: InputDecoration(
              hintText: hint,
              counterText: '',
              labelText: label,
              labelStyle: arenaLabelStyle(size: 13, color: accent, letterSpacing: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _MaxScoreStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _MaxScoreStepper({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepButton(icon: Icons.remove, onTap: () => onChanged(-1)),
        Container(
          width: 120,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$value',
            style: scoreDigitStyle(size: 56, color: AppColors.gold),
          ),
        ),
        _StepButton(icon: Icons.add, onTap: () => onChanged(1)),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.surfaceLine)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: AppColors.textPrimary, size: 22),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _StartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          'MULAI PERTANDINGAN',
          style: arenaLabelStyle(size: 20, color: AppColors.background, letterSpacing: 3),
        ),
      ),
    );
  }
}
