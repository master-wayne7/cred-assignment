import 'package:cached_network_image/cached_network_image.dart';
import 'package:cred/cubit/section_layout_cubit.dart';
import 'package:cred/cubit/selected_item_cubit.dart';
import 'package:cred/models/category_model.dart';
import 'package:cred/utils/responsive_size.dart';
import 'package:cred/widgets/animated_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionView extends StatelessWidget {
  /// A Section model will contain the all the items
  final Section section;

  /// This will render the categories of a particular section
  ///
  /// requires a model class of [section]
  const SectionView({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              section.title,
              style: TextStyle(
                color: const Color.fromRGBO(86, 86, 86, 1),
                fontSize: 15.kh,
                fontFamily: "Roboto",
              ),
            ),
          ],
        ),

        // Section Content (Grid or List View)
        BlocBuilder<SectionLayoutCubit, bool>(
          builder: (context, isGridView) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final int itemCount = section.items.length;
                final int rows = isGridView ? (itemCount / 4).ceil() : itemCount; // 4 is the cross axis count
                final double itemHeight = isGridView ? 150 : 100; // Can adjust item height
                final double totalHeight = rows * itemHeight + (rows - 1) * 10; // will calculate the height required by the section
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: totalHeight.kh,
                  child: Stack(
                    children: [
                      for (int index = 0; index < section.items.length; index++) _buildAnimatedItem(index, maxWidth, isGridView, context)
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  /// This method will calculate the position of each item based on the layout
  ///
  /// requires [index] of item, [maxwidth] of layout, whether the layout [isGrid] or not
  Offset _getTargetPosition(int index, double maxWidth, bool isGrid) {
    if (isGrid) {
      // Grid layout: 4 items per row
      int row = index ~/ 4;
      int col = index % 4;
      double itemWidth = maxWidth / 4;
      return Offset((col * itemWidth).kw, (row * 120 + 2).kh); // Adjust sizes as needed
    } else {
      // List layout: Single item per row
      return Offset(0, (index * 100.0 + 2).kh); // Adjust sizes as needed
    }
  }

  /// Method to build the item with the animation
  ///
  /// requires [index] of item, [maxwidth] of layout, whether the layout [isGrid] or not
  Widget _buildAnimatedItem(int index, double maxWidth, bool isGrid, BuildContext context) {
    final item = section.items[index];
    final targetPosition = _getTargetPosition(index, maxWidth, isGrid);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: targetPosition.dx,
      top: targetPosition.dy,
      width: (isGrid ? maxWidth / 4 - 7 : maxWidth - 5).kw,
      height: isGrid ? (150).kh : 111.kh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // selecting a particular category
              context.read<SelectedItemCubit>().selectItem(item);
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.kw, vertical: 16.kh),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 82, 82, 82), width: 0.5),
                  ),
                  child: Center(
                    // caching the network image
                    child: CachedNetworkImage(
                      imageUrl: item.iconUrl,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 30.kw,
                          height: 30.kh,
                          child: const CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.warning,
                          color: Colors.white,
                          size: 26.kh,
                        ),
                      ),
                      width: 50.kw,
                      height: 50.kh,
                    ),
                  ),
                ),
                // will show row only in list layout
                AnimatedRow(isGrid: isGrid, item: item),
              ],
            ),
          ),
          // will show title only in grid layout
          if (isGrid) ...[
            10.kheightBox,
            GestureDetector(
              onTap: () {
                // selecting a particular category when the name is tapped
                context.read<SelectedItemCubit>().selectItem(item);
                Navigator.pop(context);
              },
              child: Text(
                item.name,
                style: TextStyle(color: Colors.white, fontSize: 12.kh, fontFamily: "Roboto"),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
