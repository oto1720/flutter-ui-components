import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 横スワイプで切り替える画像カルーセル（スライダー）。
///
/// 設計方針:
/// - [PageView] でページ送りを実現し、下に現在位置を示すドットを並べる。
/// - 現在ページは内部状態として持つ（時間で変わるので StatefulWidget）。
/// - 画像の読み込み失敗に備えて errorBuilder を用意しておく。
class AppCarousel extends StatefulWidget {
  const AppCarousel({super.key, required this.imageUrls, this.height = 180});

  final List<String> imageUrls;
  final double height;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  final _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imageUrls.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, _, _) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image_outlined),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // 現在ページを示すドット。
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.imageUrls.length; i++)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _current
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
