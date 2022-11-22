import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBtn extends StatefulWidget {
  final int index;
  final int currentIndex;
  final IconData? icon;
  final VoidCallback onPressed;
  final String? imgUrl;
  final String title;
  final int totalItems;
  final int total;
  final bool isMessage;
  final Color? color;
  final String? emoji;
  final bool? hideIcons;
  final Color? iconColor;
  const CustomBtn({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.onPressed,
    this.icon,
    this.imgUrl,
    required this.title,
    required this.totalItems,
    required this.total,
    required this.isMessage,
    this.color,
    this.emoji,
    this.hideIcons = false,
    this.iconColor,
  }) : super(key: key);

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _buttonAnimationController;
  late Animation<Color?> _iconColorAnimation;
  late Animation<Color?> _iconColorDarkAnimation;
  late Animation<double> _buttonUpAnimation;
  late Animation<Color?> _buttonSelectedAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _iconColorAnimation = ColorTween(
      begin: BrandColors.kBrandSecondary,
      end: BrandColors.kBtnHoverColor,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _iconColorDarkAnimation = ColorTween(
      begin: widget.iconColor,
      end: BrandColors.kBtnHoverColor,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _buttonSelectedAnimation = ColorTween(
      begin: BrandColors.kBrandTextDark.withOpacity(0.0),
      end: BrandColors.kBrandTextDark.withOpacity(0.2),
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: const Interval(
          0.0,
          0.50,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _buttonUpAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: const Interval(
          0.30,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.index == widget.currentIndex
        ? _buttonAnimationController.forward()
        : _buttonAnimationController.reverse();
    return BlocBuilder<ThemeBloc, ThemeTab>(builder: (context, activeTab) {
      return GestureDetector(
        onTap: () => widget.onPressed(),
        child: AnimatedBuilder(
            animation: _buttonAnimationController,
            builder: (context, child) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  // vertical: 10,
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: _buttonSelectedAnimation.value,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                    ),
                    widget.hideIcons == true
                        ? Container()
                        : Positioned(
                            top: 10,
                            child: Transform.translate(
                              offset: Offset(0.0, -_buttonUpAnimation.value),
                              child: widget.icon != null
                                  ? Icon(
                                      widget.icon,
                                      //color: _iconColorAnimation.value,
                                      color: activeTab == ThemeTab.light
                                          ? _iconColorAnimation.value
                                          : _iconColorDarkAnimation.value,
                                      size: 13.0,
                                    )
                                  : widget.emoji != null
                                      ? Transform.translate(
                                          offset: const Offset(0.0, -8.0),
                                          child: Text(
                                            widget.emoji!,
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 13.0,
                                          width: 13.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.9),
                                            border: Border.all(
                                              color: widget.color!,
                                              width: 2.5,
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                    Positioned(
                      top: 10,
                      left: widget.hideIcons == true ? 0.0 : 30.0,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: widget.index == widget.currentIndex
                                  ? BrandColors.kBtnHoverColor
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                              fontSize: 13.0,
                            ),
                      ),
                    ),
                    widget.hideIcons == true
                        ? Container()
                        : Positioned(
                            top: 10,
                            right: 0.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    BrandColors.kBrandTextDark.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                '12',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: BrandColors.kBrandSecondary,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          )
                  ],
                ),
              );
            }),
      );
    });
  }
}
