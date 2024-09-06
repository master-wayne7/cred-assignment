import 'package:cred/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatelessWidget {
  /// current value of the switch
  final bool value;

  /// function to call when the switch is toggled
  final void Function() onChanged;

  /// Customized togglable switch
  ///
  /// requires a bool [value], and function when switch is toggled [onChanged]
  const CustomToggleSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        width: 45.kh,
        height: 24.kh,
        padding: EdgeInsets.all(2.kh),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: 20.kh,
            height: 20.kh,
            color: Colors.white,
            child: Icon(
              value ? Icons.grid_view_rounded : Icons.list,
              color: Colors.black,
              size: 15.kh,
            ),
          ),
        ),
      ),
    );
  }
}
