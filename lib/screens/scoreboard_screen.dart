import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/match_settings.dart';
import '../theme/app_theme.dart';
import '../widgets/player_panel.dart';
import '../widgets/win_overlay.dart';

class ScoreboardScreen extends StatefulWidget {
  final MatchSettings initialSettings;

  const ScoreboardScreen({super.key, required this.initialSettings});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  late MatchSettings _settings;
  int _score1 = 0;
  int _score2 = 0;

  @override
  void initState() {
    super.initState();
    _settings = widget.initialSettings;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String? get _winnerName {
    if (_score1 >= _settings.maxScore) return _settings.player1Name;
    if (_score2 >= _settings.maxScore) return _settings.player2Name;
    return null;
  }

  bool get _matchInProgress =>
      (_score1 > 0 || _score2 > 0) && _winnerName == null;

  void _increment(int player) {
    if (_winnerName != null) return;
    setState(() {
      if (player == 1) {
        _score1++;
      } else {
        _score2++;
      }
    });
  }

  void _decrement(int player) {
    if (_winnerName != null) return;
    setState(() {
      if (player == 1) {
        _score1 = (_score1 - 1).clamp(0, _settings.maxScore).toInt();
      } else {
        _score2 = (_score2 - 1).clamp(0, _settings.maxScore).toInt();
      }
    });
  }

  void _rematch() {
    setState(() {
      _score1 = 0;
      _score2 = 0;
    });
  }

  Future<bool> _confirmIfInProgress(String message) async {
    if (!_matchInProgress) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Yakin?', style: arenaLabelStyle(size: 20, color: AppColors.textPrimary)),
        content: Text(message, style: const TextStyle(color: AppColors.textMuted)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('BATAL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('YA'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _handleReset() async {
    final ok = await _confirmIfInProgress(
      'Skor saat ini akan diatur ulang ke 0.',
    );
    if (ok) _rematch();
  }

  Future<void> _handleBackToSetup() async {
    final ok = await _confirmIfInProgress(
      'Pertandingan yang sedang berjalan akan dibatalkan.',
    );
    if (ok && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final winner = _winnerName;

    return PopScope(
      canPop: !_matchInProgress,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final ok = await _confirmIfInProgress(
          'Pertandingan yang sedang berjalan akan dibatalkan.',
        );
        if (ok && mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PlayerPanel(
                      name: _settings.player1Name,
                      score: _score1,
                      maxScore: _settings.maxScore,
                      accent: AppColors.playerOne,
                      accentDim: AppColors.playerOneDim,
                      isWinner: winner == _settings.player1Name,
                      onIncrement: () => _increment(1),
                      onDecrement: () => _decrement(1),
                    ),
                  ),
                  _CenterDivider(
                    maxScore: _settings.maxScore,
                    onReset: _handleReset,
                    onBack: _handleBackToSetup,
                  ),
                  Expanded(
                    child: PlayerPanel(
                      name: _settings.player2Name,
                      score: _score2,
                      maxScore: _settings.maxScore,
                      accent: AppColors.playerTwo,
                      accentDim: AppColors.playerTwoDim,
                      isWinner: winner == _settings.player2Name,
                      onIncrement: () => _increment(2),
                      onDecrement: () => _decrement(2),
                    ),
                  ),
                ],
              ),
              if (winner != null)
                Positioned.fill(
                  child: WinOverlay(
                    winnerName: winner,
                    accent: winner == _settings.player1Name
                        ? AppColors.playerOne
                        : AppColors.playerTwo,
                    score1: _score1,
                    score2: _score2,
                    onRematch: _rematch,
                    onNewSettings: () => Navigator.of(context).pop(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterDivider extends StatelessWidget {
  final int maxScore;
  final VoidCallback onReset;
  final VoidCallback onBack;

  const _CenterDivider({
    required this.maxScore,
    required this.onReset,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 20),
            tooltip: 'Kembali ke pengaturan',
          ),
          const Spacer(),
          Text('VS', style: arenaLabelStyle(size: 22, color: AppColors.gold, letterSpacing: 2)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.surfaceLine),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'MAX $maxScore',
              style: arenaLabelStyle(size: 12, color: AppColors.textMuted, letterSpacing: 1),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.refresh, color: AppColors.textMuted, size: 20),
            tooltip: 'Atur ulang skor',
          ),
        ],
      ),
    );
  }
}
