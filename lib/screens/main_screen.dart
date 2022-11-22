import 'package:fake_dona_app/blocs/Settings/theme_bloc.dart';
import 'package:fake_dona_app/blocs/Settings/theme_event.dart';
import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/models/bar_model.dart';
import 'package:fake_dona_app/models/theme_tab.dart';
import 'package:fake_dona_app/widgets/custom_bar.dart';
import 'package:fake_dona_app/widgets/theme_changer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ThemeIntent extends Intent {
  const ThemeIntent({this.name = ''});

  final String name;
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  FocusNode focusNode = FocusNode();
  GlobalKey introKey = GlobalKey();
  GlobalKey introKey2 = GlobalKey();
  GlobalKey introKey3 = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  int buttonIndex = 0;
  int currentIndexThemeIndex = 0;
  late AnimationController _controller;
  //late Animation<double> _animation;

  late AnimationController _controller2;

  late Animation<double> _animation2;

  late Animation<double> _buttonUpAnimation;

  late AnimationController _settingsController;

  late Animation<Color?> _opacityAnimation;

  late Animation<double> _settingsSlideAnimation;

  late Animation<double> _settingsOpacityAnimation;

  final List<BarModel> _barModels = [
    const BarModel(
      icon: Ionicons.home,
      total: 0,
      title: 'Home',
    ),
    const BarModel(
      icon: Ionicons.calendar_clear_outline,
      total: 0,
      title: 'Today',
    ),
    const BarModel(
      icon: Ionicons.checkbox_outline,
      total: 0,
      title: 'Completed',
    ),
    const BarModel(
      color: Colors.red,
      total: 0,
      title: 'Personal',
    ),
    const BarModel(
      color: Colors.blue,
      total: 0,
      title: 'Work',
    ),
    const BarModel(
      color: Colors.green,
      total: 1,
      title: 'Errands',
    ),
    const BarModel(
      emoji: '🏡',
      total: 0,
      title: 'House',
    ),
    const BarModel(
      emoji: '🚗',
      total: 0,
      title: 'Road trip list',
    ),
  ];

  final List<BarModel> _barModels2 = [
    const BarModel(
      icon: Ionicons.home,
      total: 0,
      title: 'Personal',
    ),
    const BarModel(
      icon: Ionicons.calendar_clear_outline,
      total: 0,
      title: 'Password',
    ),
    const BarModel(
      color: Colors.red,
      total: 0,
      title: 'Appearance',
    ),
    const BarModel(
      color: Colors.blue,
      total: 0,
      title: 'Shortcuts',
    ),
    const BarModel(
      color: Colors.green,
      total: 1,
      title: 'Misc',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _settingsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: const Interval(
          0.0,
          0.50,
          curve: Curves.easeInOut,
        ),
      ),
    );

    // _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: const Interval(0.1, 1.0, curve: Curves.easeInOut),
    // ));

    _buttonUpAnimation = Tween(begin: -250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: const Interval(
          0.50,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _opacityAnimation = ColorTween(
            begin: Colors.black.withOpacity(0.0),
            end: Colors.black.withOpacity(0.4))
        .animate(
      CurvedAnimation(
        parent: _settingsController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _settingsSlideAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _settingsController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _settingsOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _settingsController,
        curve: const Interval(
          0.9,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _controller2.forward();
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller.dispose();
    _settingsController.dispose();
    super.dispose();
  }

  void _changeTheme(String name) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    switch (name) {
      case 'light':
        themeBloc.add(LightTab(ThemeTab.values[0]));
        break;
      case 'dark':
        themeBloc.add(DarkTab(ThemeTab.values[1]));
        break;
      case 'black':
        themeBloc.add(BlackTab(ThemeTab.values[2]));
        break;
      case 'auto':
        themeBloc.add(AutoTab(ThemeTab.values[3]));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    bool isHideSideBar = MediaQuery.of(context).size.width < 600;

    if (isHideSideBar) {
      _controller2.reverse();
    } else {
      _controller2.forward();
    }

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD):
            ThemeIntent(name: ThemeTab.dark.name),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyL):
            ThemeIntent(name: ThemeTab.light.name),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyB):
            ThemeIntent(name: ThemeTab.black.name),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
            ThemeIntent(name: ThemeTab.auto.name),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ThemeIntent: CallbackAction<ThemeIntent>(
              onInvoke: (ThemeIntent intent) => _changeTheme(intent.name)),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            //backgroundColor: const Color(0xFFeeeff1),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    AnimatedBuilder(
                      animation: _controller2,
                      builder: (context, child) {
                        return SizedBox(
                          // added this first.
                          // width: _animation2.value * MediaQuery.of(context).size.width * 0.3,
                          width: _animation2.value * 340,
                          height: double.infinity,
                          child: Container(
                            // second
                            height: MediaQuery.of(context).size.height,
                            // width:
                            //     _animation2.value * MediaQuery.of(context).size.width * 0.3,
                            width: _animation2.value * 400,
                            constraints: const BoxConstraints(
                              maxWidth: 480,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            margin: const EdgeInsets.symmetric(
                              // horizontal: _animation2.value * 15,
                              // vertical: _animation2.value * 15,
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              //color: BrandColors.kBrandPureWhite,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              // border: Border.all(
                              //   color: BrandColors.kBrandPureWhite,
                              //   width: 1,
                              // ),
                              borderRadius: BorderRadius.circular(18),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.2),
                              //     spreadRadius: 2,
                              //     blurRadius: 2,
                              //     offset: const Offset(0, 3),
                              //   ),
                              // ],
                            ),
                            child: Transform.translate(
                              offset: Offset(_buttonUpAnimation.value, 0.0),
                              child: ListView(
                                children: [
                                  for (var i = 0; i < _barModels.length; i++)
                                    CustomBtn(
                                      icon: _barModels[i].icon,
                                      total: _barModels[i].total!,
                                      isMessage: false,
                                      index: i,
                                      currentIndex: buttonIndex,
                                      totalItems: _barModels.length,
                                      title: _barModels[i].title,
                                      color: _barModels[i].color,
                                      emoji: _barModels[i].emoji,
                                      iconColor: BrandColors.kBrandTextDark,
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print('index: $i');
                                        }
                                        setState(() {
                                          buttonIndex = i;
                                        });

                                        _settingsController.forward();
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Flexible(
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                AnimatedBuilder(
                  animation: _settingsController,
                  builder: (context, child) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      //width: MediaQuery.of(context).size.width,
                      width: _settingsSlideAnimation.value *
                          MediaQuery.of(context).size.width,
                      color: _opacityAnimation.value,
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
                          //color: BrandColors.kBrandPureWhite,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Opacity(
                          opacity: _settingsOpacityAnimation.value,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 240,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                                    for (var i = 0;
                                        i < _barModels2.length;
                                        i++) ...[
                                      CustomBtn(
                                        icon: _barModels2[i].icon,
                                        total: _barModels2[i].total!,
                                        isMessage: false,
                                        index: i,
                                        currentIndex: buttonIndex,
                                        totalItems: _barModels2.length,
                                        title: _barModels2[i].title,
                                        color: _barModels2[i].color,
                                        emoji: _barModels2[i].emoji,
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
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 40,
                                        top: 30,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                          iconSize: 20,
                                          onPressed: () => {
                                            debugPrint('close'),
                                            _settingsController.reverse(),
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 90,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  indicatorBgColor: BrandColors
                                                      .kBrandPureWhite,
                                                  bgColor:
                                                      const Color(0xFFecedee),
                                                  index: 0,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndexThemeIndex =
                                                          0;
                                                    });
                                                    themeBloc.add(LightTab(
                                                        ThemeTab.values[0]));
                                                  },
                                                  title: 'Light',
                                                ),
                                                ThemeChanger(
                                                  bgColor: const Color(
                                                      0xFF232328), // BrandColors.kBrandPureWhite,
                                                  indicatorBgColor:
                                                      const Color(0xFF292c38),
                                                  index: 1,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndexThemeIndex =
                                                          1;
                                                    });
                                                    themeBloc.add(DarkTab(
                                                        ThemeTab.values[1]));
                                                  },
                                                  title: 'Dark',
                                                ),
                                                ThemeChanger(
                                                  bgColor: const Color(
                                                      0xFF010104), // BrandColors.kBrandPureWhite,
                                                  indicatorBgColor:
                                                      const Color(0xFF13151c),
                                                  index: 2,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndexThemeIndex =
                                                          2;
                                                    });
                                                    themeBloc.add(BlackTab(
                                                        ThemeTab.values[2]));
                                                  },
                                                  title: 'Black',
                                                ),
                                                ThemeChanger(
                                                  isAuto: true,
                                                  indicatorBgColor: BrandColors
                                                      .kBrandPureWhite,
                                                  index: 3,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndexThemeIndex =
                                                          3;
                                                    });
                                                    themeBloc.add(AutoTab(
                                                        ThemeTab.values[3]));
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.516,
                                              color: const Color(0xFFd8d8d8)
                                                  .withOpacity(0.5),
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
                                                  indicatorBgColor: BrandColors
                                                      .kBrandPureWhite,
                                                  bgColor:
                                                      const Color(0xFFecedee),
                                                  index: 0,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(() {
                                                      currentIndexThemeIndex =
                                                          0;
                                                    });
                                                  },
                                                  title: 'Default',
                                                ),
                                                ThemeChanger(
                                                  bgColor: const Color(
                                                      0xFF232328), // BrandColors.kBrandPureWhite,
                                                  indicatorBgColor:
                                                      const Color(0xFF292c38),
                                                  index: 1,
                                                  currentIndex:
                                                      currentIndexThemeIndex,
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        currentIndexThemeIndex =
                                                            1;
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.516,
                                              color: const Color(0xFFd8d8d8)
                                                  .withOpacity(0.5),
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
                                                      showDropDown(
                                                          context: context,
                                                          key: introKey),
                                                    },
                                                    child: Text(
                                                      'Saturday, ',
                                                      key: introKey,
                                                      style: TextStyle(
                                                        shadows: const [
                                                          Shadow(
                                                              color: Color(
                                                                  0xFF97959B),
                                                              offset:
                                                                  Offset(0, -4))
                                                        ],
                                                        fontSize: 14,
                                                        color:
                                                            Colors.transparent,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            const Color(
                                                                    0xFFd8d8d8)
                                                                .withOpacity(
                                                                    0.9),
                                                        decorationThickness:
                                                            1.8,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  offset: const Offset(0, 3.5),
                                                  child: GestureDetector(
                                                    onTap: () => {
                                                      showDropDown(
                                                          context: context,
                                                          key: introKey2),
                                                    },
                                                    child: Text(
                                                      'May 28 ',
                                                      key: introKey2,
                                                      style: TextStyle(
                                                        shadows: const [
                                                          Shadow(
                                                              color: Color(
                                                                  0xFF97959B),
                                                              offset:
                                                                  Offset(0, -4))
                                                        ],
                                                        fontSize: 14,
                                                        color:
                                                            Colors.transparent,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            const Color(
                                                                    0xFFd8d8d8)
                                                                .withOpacity(
                                                                    0.9),
                                                        decorationThickness:
                                                            1.8,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
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
                                                              color: Color(
                                                                  0xFF97959B),
                                                              offset:
                                                                  Offset(0, -4))
                                                        ],
                                                        fontSize: 14,
                                                        color:
                                                            Colors.transparent,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            const Color(
                                                                    0xFFd8d8d8)
                                                                .withOpacity(
                                                                    0.9),
                                                        decorationThickness:
                                                            1.8,
                                                        decorationStyle:
                                                            TextDecorationStyle
                                                                .solid,
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDropDown({required BuildContext context, required GlobalKey key}) {
    if (overlayEntry != null && overlayEntry?.mounted == true) {
      overlayEntry?.remove();
      return;
    }
    debugPrint('Overlay before ${overlayState?.mounted.toString()}');
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;
    double x = position.dx;
    debugPrint('y: $y');
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          //top: MediaQuery.of(context).size.height * 0.16,
          top: y + 20,
          //left: MediaQuery.of(context).size.width * 0.25,
          left: x,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              //width: MediaQuery.of(context).size.width * 0.7,
              //height: 179.0,
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 15.0,
                right: 15.0,
                bottom: 15.0,
              ),
              constraints: const BoxConstraints(
                maxWidth: 180.0,
                // maxHeight: 179.0,
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
                      debugPrint(overlayEntry?.mounted.toString());
                      debugPrint(overlayState?.mounted.toString());
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

    debugPrint(overlayEntry?.mounted.toString());
    debugPrint(overlayState?.mounted.toString());
    overlayState?.insert(overlayEntry!);
  }
}
