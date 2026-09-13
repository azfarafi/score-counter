class MatchSettings {
  final String player1Name;
  final String player2Name;
  final int maxScore;

  const MatchSettings({
    required this.player1Name,
    required this.player2Name,
    required this.maxScore,
  });

  MatchSettings copyWith({
    String? player1Name,
    String? player2Name,
    int? maxScore,
  }) {
    return MatchSettings(
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
      maxScore: maxScore ?? this.maxScore,
    );
  }
}
