import 'package:flutter/material.dart';

import 'neo.dart';

class TableCellWidget extends StatefulWidget {
  final int rowId;
  final int columnId;
  final String value;
  final bool isSelected;
  final bool isEditing;
  final VoidCallback onSelect;
  final VoidCallback onStartEdit;
  final VoidCallback onShowFullValue;
  final ValueChanged<String> onCommit;

  final double? width;
  final double? height;

  const TableCellWidget({
    super.key,
    required this.rowId,
    required this.columnId,
    required this.value,
    required this.isSelected,
    required this.isEditing,
    required this.onSelect,
    required this.onStartEdit,
    required this.onShowFullValue,
    required this.onCommit,
    this.width,
    this.height,
  });

  @override
  State<TableCellWidget> createState() => _TableCellWidgetState();
}

class _TableCellWidgetState extends State<TableCellWidget> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TableCellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isEditing && !oldWidget.isEditing) {
      // Entering edit mode: sync text and focus.
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focusNode.requestFocus();
      });
    }

    if (!widget.isEditing && oldWidget.isEditing) {
      // Leaving edit mode: keep controller in sync for next time.
      _controller.text = widget.value;
    }

    if (!widget.isEditing && widget.value != oldWidget.value) {
      _controller.text = widget.value;
    }
  }

  void _onFocusChanged() {
    if (!widget.isEditing) return;
    if (!_focusNode.hasFocus) {
      widget.onCommit(_controller.text);
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const minW = 100.0;
    const maxW = 200.0;

    final decoration = Neo.box(
      color: NeoColors.cell,
      selected: widget.isSelected,
    );

    Widget child;
    if (widget.isEditing) {
      child = Scrollbar(
        controller: _scrollController,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          scrollController: _scrollController,
          keyboardType: TextInputType.multiline,
          expands: true,
          maxLines: null,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
          style: Neo.bodyBold(context),
          onSubmitted: (_) => widget.onCommit(_controller.text),
        ),
      );
    } else {
      child = Text(
        widget.value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Neo.bodyBold(context),
      );
    }

    final inner = Container(
      height: widget.height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(10),
      decoration: decoration,
      child:
          widget.isEditing
              ? SizedBox(height: (widget.height ?? 56) - 20, child: child)
              : child,
    );

    final sized =
        widget.width != null
            ? SizedBox(width: widget.width, height: widget.height, child: inner)
            : ConstrainedBox(
              constraints: const BoxConstraints(minWidth: minW, maxWidth: maxW),
              child: inner,
            );

    return GestureDetector(
      onTap: () {
        widget.onSelect();
        if (widget.isSelected && !widget.isEditing) {
          widget.onStartEdit();
        }
      },
      onDoubleTap: () {
        widget.onSelect();
        widget.onStartEdit();
      },
      onLongPress: () {
        widget.onSelect();
        widget.onShowFullValue();
      },
      child: sized,
    );
  }
}
