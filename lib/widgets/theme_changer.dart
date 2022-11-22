import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeChanger extends StatefulWidget {
  final int? indicatorCount;
  final Color? indicatorBgColor;
  final Color? bgColor;
  final Color? topIndicator;
  final bool? isAuto;
  final int? index;
  final int? currentIndex;
  final VoidCallback? onTap;
  final String title;
  const ThemeChanger(
      {Key? key,
      this.indicatorCount = 4,
      this.indicatorBgColor,
      this.bgColor,
      this.topIndicator,
      this.isAuto = false,
      this.index = 0,
      this.currentIndex = 0,
      this.onTap,
      required this.title})
      : super(key: key);

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _paddingAnimation;
  late Animation<Color?> _textColorDarkAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _borderAnimation = ColorTween(
      begin: Colors.transparent,
      end: const Color(0xFF1379D9),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.black,
      end: const Color(0xFF1379D9),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 12.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _paddingAnimation = Tween<double>(
      begin: 0,
      end: 6.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _textColorDarkAnimation = ColorTween(
      begin: BrandColors.kBrandPureWhite,
      end: const Color(0xFF1379D9),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.index == widget.currentIndex
        ? _controller.forward()
        : _controller.reverse();
    return BlocBuilder<ThemeBloc, ThemeTab>(builder: (context, activeTab) {
      return GestureDetector(
        onTap: () {
          // _controller.forward();
          widget.onTap!();
        },
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: 160,
                    margin: const EdgeInsets.only(right: 18),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: widget.bgColor ??
                          (widget.isAuto == true
                              ? null
                              : Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _borderAnimation.value!,
                        width: 2.5,
                      ),
                      gradient: widget.isAuto == true
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              stops: [0.5, 0.3],
                              colors: [
                                Color(0xFFecedee),
                                Colors.black,
                              ],
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: ThemeWrap(
                            hideRound: true,
                            bgColor: widget.topIndicator,
                          ),
                        ),
                        //const SizedBox(height: 10),
                        for (int i = 1;
                            i < widget.indicatorCount! + 1;
                            i++) ...[
                          Positioned(
                            top: i == 1 ? 26.0 * i : 24.5 * i,
                            child: widget.isAuto == true
                                ? ThemeWrapAuto(
                                    hideRound: false,
                                    bgColor: widget.indicatorBgColor,
                                  )
                                : ThemeWrap(
                                    hideRound: false,
                                    bgColor: widget.indicatorBgColor,
                                  ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: _paddingAnimation.value),
                        child: Icon(
                          Icons.check,
                          color: _colorAnimation.value,
                          size: _sizeAnimation.value,
                        ),
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 12,
                          //color: _colorAnimation.value,
                          color: activeTab == ThemeTab.light
                              ? _colorAnimation.value
                              : _textColorDarkAnimation.value,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      );
    });
  }
}

class ThemeWrap extends StatefulWidget {
  final bool hideRound;
  final Color? bgColor;
  const ThemeWrap({Key? key, required this.hideRound, this.bgColor})
      : super(key: key);

  @override
  State<ThemeWrap> createState() => _ThemeWrapState();
}

class _ThemeWrapState extends State<ThemeWrap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 140,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
        left: 6,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Row(
        children: [
          widget.hideRound == true
              ? const SizedBox()
              : Container(
                  height: 7,
                  width: 7,
                  constraints: const BoxConstraints(
                    maxWidth: 7,
                    maxHeight: 7,
                  ),
                  margin: const EdgeInsets.only(
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
          Container(
            height: 4,
            width: 40,
            constraints: const BoxConstraints(
              maxWidth: 40,
              maxHeight: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(1.0),
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      ),
    );
  }
}

class ThemeWrapAuto extends StatefulWidget {
  final bool hideRound;
  final Color? bgColor;
  const ThemeWrapAuto({Key? key, required this.hideRound, this.bgColor})
      : super(key: key);

  @override
  State<ThemeWrapAuto> createState() => _ThemeWrapAutoState();
}

class _ThemeWrapAutoState extends State<ThemeWrapAuto> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 70,
          decoration: BoxDecoration(
            color: widget.bgColor ?? Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 6,
            //right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            children: [
              widget.hideRound == true
                  ? const SizedBox()
                  : Container(
                      height: 7,
                      width: 7,
                      constraints: const BoxConstraints(
                        maxWidth: 7,
                        maxHeight: 7,
                      ),
                      margin: const EdgeInsets.only(
                        right: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(1.0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
              Container(
                height: 4,
                width: 40,
                constraints: const BoxConstraints(
                  maxWidth: 40,
                  maxHeight: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 20,
          width: 70,
          decoration: const BoxDecoration(
            color: Color(0xFF292c38),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
