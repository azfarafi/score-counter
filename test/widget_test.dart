import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_pertandingan/main.dart';

void main() {
  testWidgets('Layar atur pertandingan tampil dan bisa mulai pertandingan',
      (tester) async {
    await tester.pumpWidget(const ScorePertandinganApp());

    expect(find.text('ATUR PERTANDINGAN'), findsOneWidget);
    expect(find.text('MULAI PERTANDINGAN'), findsOneWidget);

    await tester.tap(find.text('MULAI PERTANDINGAN'));
    await tester.pumpAndSettle();

    // Setelah mulai, nama default pemain (tanpa input) harus tampil.
    expect(find.text('PEMAIN 1'), findsOneWidget);
    expect(find.text('PEMAIN 2'), findsOneWidget);
  });

  testWidgets('Menambah skor pemain 1 memperbarui angka yang tampil',
      (tester) async {
    await tester.pumpWidget(const ScorePertandinganApp());
    await tester.tap(find.text('MULAI PERTANDINGAN'));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsNWidgets(2));

    // Ketuk separuh kiri layar (area Pemain 1) untuk menambah skor.
    await tester.tapAt(const Offset(50, 300));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
