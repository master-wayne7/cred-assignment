import 'package:cred/models/category_model.dart';
import 'package:cred/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class AnimatedRow extends StatefulWidget {
  /// layout state
  final bool isGrid;

  /// item to be displayed
  final Item item;

  /// This will buil the title and description of the item
  ///
  /// requires layout state [isGrid], and the [item]
  const AnimatedRow({required this.isGrid, required this.item, super.key});

  @override
  AnimatedRowState createState() => AnimatedRowState();
}

class AnimatedRowState extends State<AnimatedRow> {
  bool showRow = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isGrid) {
      if (mounted) {
        showRow = true;
      }
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // will show the row after a dealy, e.i., when the animation is completed from grid to list
    if (!widget.isGrid) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            showRow = true;
          });
        }
      });
    } else {
      setState(() {
        showRow = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 0),
      child: showRow
          ? Row(
              mainAxisSize: MainAxisSize.min,
              key: const ValueKey('row'),
              children: [
                30.kwidthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 12.kh,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.item.description,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 86, 86, 86),
                          fontFamily: "Roboto",
                          fontSize: 12.kh,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
