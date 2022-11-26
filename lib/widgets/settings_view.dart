import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:fake_dona_app/widgets/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  final VoidCallback onCloseTap;
  const SettingsView({Key? key, required this.onCloseTap}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  FocusNode focusNode = FocusNode();
  GlobalKey introKey = GlobalKey();
  GlobalKey introKey2 = GlobalKey();
  GlobalKey introKey3 = GlobalKey();
  int currentIndexThemeIndex = 0;
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Stack(
      children: [
        Positioned(
          right: 40,
          top: 30,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).iconTheme.color,
            ),
            iconSize: 20,
            onPressed: () => {debugPrint('close'), widget.onCloseTap()},
          ),
        ),
        Positioned(
          top: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Appearance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Theme',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ThemeChanger(
                    indicatorBgColor: BrandColors.kBrandPureWhite,
                    bgColor: const Color(0xFFecedee),
                    index: 0,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(() {
                        currentIndexThemeIndex = 0;
                      });
                      themeBloc.add(LightTab(ThemeTab.values[0]));
                    },
                    title: 'Light',
                  ),
                  ThemeChanger(
                    bgColor: const Color(0xFF232328),
                    indicatorBgColor: const Color(0xFF292c38),
                    index: 1,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(() {
                        currentIndexThemeIndex = 1;
                      });
                      themeBloc.add(DarkTab(ThemeTab.values[1]));
                    },
                    title: 'Dark',
                  ),
                  ThemeChanger(
                    bgColor:
                        const Color(0xFF010104), // BrandColors.kBrandPureWhite,
                    indicatorBgColor: const Color(0xFF13151c),
                    index: 2,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(() {
                        currentIndexThemeIndex = 2;
                      });
                      themeBloc.add(BlackTab(ThemeTab.values[2]));
                    },
                    title: 'Black',
                  ),
                  ThemeChanger(
                    isAuto: true,
                    indicatorBgColor: BrandColors.kBrandPureWhite,
                    index: 3,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(() {
                        currentIndexThemeIndex = 3;
                      });
                      themeBloc.add(AutoTab(ThemeTab.values[3]));
                    },
                    title: 'Auto',
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                height: 1,
                width: MediaQuery.of(context).size.width * 0.516,
                color: const Color(0xFFd8d8d8).withOpacity(0.5),
              ),
              const Text(
                'View',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ThemeChanger(
                    indicatorBgColor: BrandColors.kBrandPureWhite,
                    bgColor: const Color(0xFFecedee),
                    index: 0,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(() {
                        currentIndexThemeIndex = 0;
                      });
                    },
                    title: 'Default',
                  ),
                  ThemeChanger(
                    bgColor:
                        const Color(0xFF232328), // BrandColors.kBrandPureWhite,
                    indicatorBgColor: const Color(0xFF292c38),
                    index: 1,
                    currentIndex: currentIndexThemeIndex,
                    onTap: () {
                      setState(
                        () {
                          currentIndexThemeIndex = 1;
                        },
                      );
                    },
                    title: 'Compact',
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                height: 1,
                width: MediaQuery.of(context).size.width * 0.516,
                color: const Color(0xFFd8d8d8).withOpacity(0.5),
              ),
              const Text(
                'Intro',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Good afternoon Aaron,',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'It\'s ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF97959B),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 3.5),
                    child: GestureDetector(
                      onTap: () => {
                        showDropDown(context: context, key: introKey),
                      },
                      child: Text(
                        'Saturday, ',
                        key: introKey,
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                                color: Color(0xFF97959B), offset: Offset(0, -4))
                          ],
                          fontSize: 14,
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              const Color(0xFFd8d8d8).withOpacity(0.9),
                          decorationThickness: 1.8,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 3.5),
                    child: GestureDetector(
                      onTap: () => {
                        showDropDown(context: context, key: introKey2),
                      },
                      child: Text(
                        'May 28 ',
                        key: introKey2,
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                                color: Color(0xFF97959B), offset: Offset(0, -4))
                          ],
                          fontSize: 14,
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              const Color(0xFFd8d8d8).withOpacity(0.9),
                          decorationThickness: 1.8,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' - ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF97959B),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 3.5),
                    child: GestureDetector(
                      onTap: () => {
                        showDropDown(
                          context: context,
                          key: introKey3,
                        ),
                      },
                      child: Text(
                        '10 tasks ',
                        key: introKey3,
                        style: TextStyle(
                          shadows: const [
                            Shadow(
                                color: Color(0xFF97959B), offset: Offset(0, -4))
                          ],
                          fontSize: 14,
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              const Color(0xFFd8d8d8).withOpacity(0.9),
                          decorationThickness: 1.8,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void showDropDown({required BuildContext context, required GlobalKey key}) {
    if (overlayEntry != null && overlayEntry?.mounted == true) {
      overlayEntry?.remove();
      return;
    }
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;
    double x = position.dx;
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: y + 20,
          left: x,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 15.0,
                right: 15.0,
                bottom: 15.0,
              ),
              constraints: const BoxConstraints(
                maxWidth: 180.0,
              ),
              decoration: BoxDecoration(
                color: BrandColors.kBrandPureWhite,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      overlayEntry?.remove();
                      overlayState?.deactivate();
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Weekday',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: BrandColors.kBrandSecondary,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.check,
                          color: Color(0xFF1379D9),
                          size: 12.5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  const Text(
                    'Weekday (Short)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: BrandColors.kBrandSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (overlayEntry != null && overlayEntry?.mounted == true) {
      overlayEntry?.remove();
      return;
    }
    overlayState?.insert(overlayEntry!);
  }
}
