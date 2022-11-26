import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/core/dummy_data.dart';
import 'package:fake_dona_app/widgets/custom_bar.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  final Animation animation;
  final Animation sidebarAnimation;
  final Animation buttonUpAnimation;
  final VoidCallback onTap;
  const SideBar({Key? key, animtion, required this.animation, required this.sidebarAnimation, required this.buttonUpAnimation, required this.onTap}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int buttonIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.sidebarAnimation.value * 340,
          height: double.infinity,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: widget.sidebarAnimation.value * 400,
            constraints: const BoxConstraints(
              maxWidth: 480,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Transform.translate(
              offset: Offset(widget.buttonUpAnimation.value, 0.0),
              child: ListView(
                children: [
                  for (var i = 0; i < barModels.length; i++)
                    CustomBtn(
                      icon: barModels[i].icon,
                      total: barModels[i].total!,
                      isMessage: false,
                      index: i,
                      currentIndex: buttonIndex,
                      totalItems: barModels.length,
                      title: barModels[i].title,
                      color: barModels[i].color,
                      emoji: barModels[i].emoji,
                      iconColor: BrandColors.kBrandTextDark,
                      onPressed: () {
                        setState(() {
                          buttonIndex = i;
                        });
                        widget.onTap();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
