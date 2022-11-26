import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTodos extends StatefulWidget {
  final String title;
  const CustomTodos({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomTodos> createState() => _CustomTodosState();
}

class _CustomTodosState extends State<CustomTodos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      child: Row(
        children: [
          Container(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: BrandColors.kGreyColor,
            ),
            margin: const EdgeInsets.only(right: 6.0),
          ),
          Text(widget.title),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 4.0,
            ),
            margin: const EdgeInsets.only(
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: BrandColors.kGreyColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const Text(
              '10 Mar',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ),
          const Text('🚗'),
        ],
      ),
    );
  }
}
