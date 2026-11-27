import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable VIVA-styled search bar reproducing the dark navy/purple capsule
/// with a thin purple border, subtle purple glow, cyan search icon, grey
/// placeholder text, dynamic clear button, and an optional pink filter icon.
class CustomSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final bool showFilterIcon;
  final VoidCallback? onFilterTap;
  final bool hasActiveFilter;
  final bool readOnly;
  final bool autofocus;
  final bool enabled;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? glowColor;
  final bool showGlow;
  final Color? searchIconColor;
  final Color? filterIconColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget? leadingIcon;
  final Widget? filterIcon;
  final String? filterTooltip;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onTap,
    this.showFilterIcon = false,
    this.onFilterTap,
    this.hasActiveFilter = false,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.textInputAction = TextInputAction.search,
    this.keyboardType = TextInputType.text,
    this.height = AppDimensions.textFieldHeight,
    this.borderRadius = AppDimensions.buttonRadius,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppDimensions.space16,
    ),
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.glowColor,
    this.showGlow = true,
    this.searchIconColor,
    this.filterIconColor,
    this.textStyle,
    this.hintStyle,
    this.leadingIcon,
    this.filterIcon,
    this.filterTooltip = 'Filter',
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController? _internalController;
  FocusNode? _internalFocusNode;
  bool _isFocused = false;
  bool _hasText = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    _hasText = _effectiveController.text.isNotEmpty;
    _isFocused = _effectiveFocusNode.hasFocus;
    _effectiveController.addListener(_handleTextChange);
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant CustomSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTextChange);
      _internalController?.removeListener(_handleTextChange);

      if (widget.controller == null) {
        _internalController ??= TextEditingController(
          text: oldWidget.controller?.text ?? '',
        );
      } else {
        _internalController?.dispose();
        _internalController = null;
      }

      _effectiveController.addListener(_handleTextChange);
      _hasText = _effectiveController.text.isNotEmpty;
    }

    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      _internalFocusNode?.removeListener(_handleFocusChange);

      if (widget.focusNode == null) {
        _internalFocusNode ??= FocusNode();
      } else {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }

      _effectiveFocusNode.addListener(_handleFocusChange);
      _isFocused = _effectiveFocusNode.hasFocus;
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleTextChange);
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _internalController?.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    final hasTextNow = _effectiveController.text.isNotEmpty;
    if (hasTextNow != _hasText) {
      setState(() {
        _hasText = hasTextNow;
      });
    }
  }

  void _handleFocusChange() {
    final isFocusedNow = _effectiveFocusNode.hasFocus;
    if (isFocusedNow != _isFocused) {
      setState(() {
        _isFocused = isFocusedNow;
      });
    }
  }

  void _handleClear() {
    _effectiveController.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackground =
        widget.backgroundColor ?? AppColors.searchBackground;
    final effectiveBorderColor = _isFocused
        ? (widget.focusedBorderColor ?? AppColors.primaryPurple)
        : (widget.borderColor ??
            AppColors.primaryPurple.withValues(alpha: 0.65));
    final effectiveGlowColor = widget.glowColor ??
        AppColors.primaryPurple.withValues(alpha: _isFocused ? 0.34 : 0.22);
    final effectiveRadius = BorderRadius.circular(widget.borderRadius);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      height: widget.height,
      padding: widget.contentPadding,
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: effectiveBorderColor,
          width: _isFocused ? 1.5 : 1.1,
        ),
        boxShadow: widget.showGlow
            ? [
                BoxShadow(
                  color: effectiveGlowColor,
                  blurRadius: _isFocused ? 14.0 : 10.0,
                  spreadRadius: 0.0,
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.leadingIcon ??
              Icon(
                Icons.search_rounded,
                color: widget.searchIconColor ?? AppColors.accentCyan,
                size: 21.0,
              ),
          const SizedBox(width: AppDimensions.space12),
          Expanded(
            child: TextField(
              controller: _effectiveController,
              focusNode: _effectiveFocusNode,
              readOnly: widget.readOnly,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: widget.textStyle ?? AppTextStyles.input,
              cursorColor: AppColors.primaryPink,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    AppTextStyles.hint.copyWith(color: AppColors.mutedText),
                filled: false,
                isDense: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          if (_hasText && widget.enabled) ...[
            const SizedBox(width: AppDimensions.space4),
            _SearchBarIconAction(
              tooltip: 'Clear search',
              onTap: _handleClear,
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.secondaryText,
                size: 18.0,
              ),
            ),
          ],
          if (widget.showFilterIcon) ...[
            const SizedBox(width: AppDimensions.space4),
            _SearchBarIconAction(
              tooltip: widget.filterTooltip,
              onTap: widget.enabled ? widget.onFilterTap : null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  widget.filterIcon ??
                      Icon(
                        Icons.tune_rounded,
                        color: widget.filterIconColor ?? AppColors.primaryPink,
                        size: 21.0,
                      ),
                  if (widget.hasActiveFilter)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 7.0,
                        height: 7.0,
                        decoration: const BoxDecoration(
                          color: AppColors.accentCyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchBarIconAction extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? tooltip;

  const _SearchBarIconAction({
    required this.child,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: child,
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    return button;
  }
}
