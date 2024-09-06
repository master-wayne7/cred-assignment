import 'package:cred/bloc/category_bloc.dart';
import 'package:cred/cubit/section_layout_cubit.dart';
import 'package:cred/utils/responsive_size.dart';
import 'package:cred/widgets/custom_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../widgets/section_view.dart';

class CategoryPage extends StatelessWidget {
  /// This page will show all the categories in swappable layout
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.kh),
            child: Column(
              children: [
                10.kheightBox,
                _buildTopBar(),
                20.kheightBox,

                // will build the layout based on the current state
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return _buildLoading();
                    } else if (state is CategoryLoaded) {
                      return _buildContent(state);
                    } else if (state is CategoryError) {
                      return _buildError();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This widget will build the top bar with title and the switch
  Widget _buildTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'explore',
              style: TextStyle(
                color: const Color.fromRGBO(86, 86, 86, 1),
                fontSize: 15.kh,
                fontFamily: "Roboto",
              ),
            ),
            Text(
              'CRED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.kh,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.kh,
                fontFamily: "Roboto",
              ),
            ),
          ],
        ),
        const Spacer(),

        // this switch will be responsible for the switching of layout
        BlocBuilder<SectionLayoutCubit, bool>(
          builder: (context, isGridView) {
            return CustomToggleSwitch(
              value: isGridView,
              onChanged: () {
                context.read<SectionLayoutCubit>().toggleLayout();
              },
            );
          },
        ),
        30.kwidthBox,
        Container(
          width: 24.kh,
          height: 24.kh,
          padding: EdgeInsets.all(2.kh),
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 15.kh,
            ),
          ),
        )
      ],
    );
  }

  /// Custom loading widget with the lottie animation
  Widget _buildLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.h,
          width: double.infinity,
        ),
        LottieBuilder.asset(
          "assets/lottie/loading.json",
          repeat: true,
        ),
      ],
    );
  }

  /// This will build the layout based on the state
  ///
  /// [state] contains the fetched categories from network
  Widget _buildContent(CategoryLoaded state) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: state.categoryResponse.sections.length,
      itemBuilder: (context, index) {
        final section = state.categoryResponse.sections[index];
        return SectionView(section: section);
      },
    );
  }

  /// This widget will be shown when an error occurs
  Widget _buildError() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32.h,
          width: double.infinity,
        ),
        Icon(
          Icons.error,
          color: Colors.white,
          size: 40.kh,
        ),
        15.kheightBox,
        Text(
          "Oops! Some error occurred😓",
          style: TextStyle(
            fontSize: 20.kh,
            fontFamily: "Roboto",
          ),
        ),
      ],
    );
  }
}
