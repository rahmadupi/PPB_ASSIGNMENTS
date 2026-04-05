import 'package:flutter/material.dart';

import 'neo.dart';

class TableHeaderCell extends StatelessWidget {
  final String text;
  final double minWidth;
  final double maxWidth;

  final double? width;
  final double? height;

  final List<PopupMenuEntry<String>>? menuItems;
  final ValueChanged<String>? onMenuSelected;

  const TableHeaderCell({
    super.key,
    required this.text,
    this.minWidth = 100,
    this.maxWidth = 200,
    this.width,
    this.height,
    this.menuItems,
    this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final hasMenu = menuItems != null && onMenuSelected != null;

    final inner = Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      decoration: Neo.box(color: NeoColors.header),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Neo.bodyBold(context),
            ),
          ),
          if (hasMenu)
            PopupMenuButton<String>(
              iconColor: Colors.black,
              onSelected: onMenuSelected,
              itemBuilder: (context) => menuItems!,
            ),
        ],
      ),
    );

    if (width != null) {
      return SizedBox(width: width, height: height, child: inner);
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      child: inner,
    );
  }
}
