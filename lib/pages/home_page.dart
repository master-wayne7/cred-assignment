import 'package:cached_network_image/cached_network_image.dart';
import 'package:cred/bloc/category_bloc.dart';
import 'package:cred/cubit/selected_item_cubit.dart';
import 'package:cred/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'category_page.dart';

class HomePage extends StatelessWidget {
  /// Home Page of the app with the selected category
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedItemCubit = context.watch<SelectedItemCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.kh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),

            /// Logo image
            if (selectedItemCubit.state != null)
              CachedNetworkImage(
                imageUrl: selectedItemCubit.state!.iconUrl,
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
                width: 120.kw,
                height: 120.kh,
              )
            else
              // Placeholder image when nothing's selected
              Image.asset(
                "assets/images/cred.png",
                width: 120.kw,
                height: 120.kh,
              ),
            80.kheightBox,
            Text(
              'CRED ${selectedItemCubit.state?.name ?? ""}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.kh,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),
            20.kheightBox,
            Flexible(
              child: Text(
                selectedItemCubit.state?.description ?? "Pay your credit card bills and earn rewards", // placeholder tagline when nothing is selected
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22.kh,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            20.kheightBox,

            // Button to navigate to category screen
            NeoPopButton(
              color: Colors.white,
              onTapUp: () {
                HapticFeedback.vibrate();
                final bloc = context.read<CategoryBloc>();
                if (bloc.state == CategoryInitial() || bloc.state == CategoryError()) {
                  // will call the API only if the it is intial or error state
                  bloc.add(LoadCategories()); // add load event in bloc
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.kh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Go to category',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.kh,
                      ),
                    ),
                    10.kwidthBox,
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
