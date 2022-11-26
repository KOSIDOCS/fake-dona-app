import 'package:fake_dona_app/core/dummy_data.dart';
import 'package:fake_dona_app/widgets/custom_bar.dart';
import 'package:fake_dona_app/widgets/settings_view.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Animation settingsController;
  final Animation settingsSlideAnimation;
  final Animation opacityAnimation;
  final Animation settingsOpacityAnimation;
  final VoidCallback onCloseTap;
  const SettingsScreen(
      {Key? key,
      required this.settingsController,
      required this.settingsSlideAnimation,
      required this.opacityAnimation,
      required this.settingsOpacityAnimation,
      required this.onCloseTap})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (context, child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: widget.settingsSlideAnimation.value *
              MediaQuery.of(context).size.width,
          color: widget.opacityAnimation.value,
          child: Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.only(
              top: 6.0,
              left: 310,
              bottom: 6.0,
              right: 6.0,
            ),
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Opacity(
              opacity: widget.settingsOpacityAnimation.value,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 240,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 40,
                      bottom: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        for (var i = 0; i < barModels2.length; i++) ...[
                          CustomBtn(
                            icon: barModels2[i].icon,
                            total: barModels2[i].total!,
                            isMessage: false,
                            index: i,
                            currentIndex: buttonIndex,
                            totalItems: barModels2.length,
                            title: barModels2[i].title,
                            color: barModels2[i].color,
                            emoji: barModels2[i].emoji,
                            hideIcons: true,
                            onPressed: () {
                              setState(() {
                                buttonIndex = i;
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SettingsView(
                        onCloseTap: () => widget.onCloseTap(),
                      ),
                    ),
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
