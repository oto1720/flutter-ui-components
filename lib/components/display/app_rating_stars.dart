import 'package:flutter/material.dart';

/// 星による評価表示（★★★☆☆）。
///
/// 設計方針:
/// - [onRatingChanged] を渡すと「入力可能」、渡さなければ「表示専用」。
///   コールバックの有無で振る舞いが変わるのは Flutter でよくある設計。
/// - [rating] は親が持つ状態。星をタップすると新しい値を通知する。
class AppRatingStars extends StatelessWidget {
  const AppRatingStars({
    super.key,
    required this.rating,
    this.count = 5,
    this.size = 28,
    this.onRatingChanged,
  });

  final int rating;
  final int count;
  final double size;
  final ValueChanged<int>? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= count; i++)
          GestureDetector(
            // 入力可能なときだけタップに反応する。
            onTap: onRatingChanged != null ? () => onRatingChanged!(i) : null,
            child: Icon(
              i <= rating ? Icons.star : Icons.star_border,
              size: size,
              color: color,
            ),
          ),
      ],
    );
  }
}
