import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 検索用の入力フィールド（虫眼鏡アイコン＋クリアボタン付き）。
///
/// 設計方針:
/// - 入力があるときだけクリアボタンを出す。そのために controller を
///   [ListenableBuilder] で監視し、文字が変わるたびにアイコン部分を作り直す。
///   （build の中で `controller.text` を 1 回読むだけでは、入力しても
///   再描画されないのでボタンが出ない。）
/// - [controller] は任意。渡されなければ内部で用意して、最後に破棄する。
///   「自分で作ったものだけ自分で dispose する」のが StatefulWidget の基本。
/// - AppTextField の応用形。`prefixIcon` / `suffixIcon` の使い方の例。
/// - 形だけ他の入力欄と変えて（丸い・枠線なし）、検索欄だと分かるようにしている。
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = '検索',
    this.onChanged,
    this.onClear,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  // 外から渡されなかったときだけ使う、自前の controller。
  TextEditingController? _ownController;

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController());

  @override
  void dispose() {
    _ownController?.dispose(); // 自分で作った分だけ破棄する
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search),
            // 入力があるときだけクリアボタンを表示する。
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'クリア',
                    onPressed: _clear,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}
