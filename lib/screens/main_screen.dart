import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/models/theme_tab.dart';
import 'package:fake_dona_app/screens/settings_screen.dart';
import 'package:fake_dona_app/utils/custom_intents.dart';
import 'package:fake_dona_app/utils/helpers.dart';
import 'package:fake_dona_app/widgets/main_view.dart';
import 'package:fake_dona_app/widgets/side_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  late AnimationController _controller2;

  late Animation<double> _animation2;

  late Animation<double> _buttonUpAnimation;

  late AnimationController _settingsController;

  late Animation<Color?> _opacityAnimation;

  late Animation<double> _settingsSlideAnimation;

  late Animation<double> _settingsOpacityAnimation;

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
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller.dispose();
    _settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isHideSideBar = MediaQuery.of(context).size.width < 600;

    if (isHideSideBar) {
      _controller2.reverse();
    } else {
      _controller2.forward();
    }

    return BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
      if (state is TodosLoading) {
        if (kDebugMode) {
          print('Still loading here');
        }
      } else if (state is TodosLoaded) {
        final todos = state;
        if (kDebugMode) {
          print('All todos here');
          print(todos.todos);
        }
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
                onInvoke: (ThemeIntent intent) =>
                    changeTheme(intent.name, context: context)),
          },
          child: Focus(
            autofocus: true,
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: Stack(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      SideBar(
                        animation: _controller2,
                        sidebarAnimation: _animation2,
                        buttonUpAnimation: _buttonUpAnimation,
                        onTap: () {
                          _settingsController.forward();
                        },
                      ),
                      const Flexible(
                        child: MainView(),
                      ),
                    ],
                  ),
                  SettingsScreen(
                    settingsController: _settingsController,
                    settingsSlideAnimation: _settingsSlideAnimation,
                    opacityAnimation: _opacityAnimation,
                    settingsOpacityAnimation: _settingsOpacityAnimation,
                    onCloseTap: () {
                      _settingsController.reverse();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
