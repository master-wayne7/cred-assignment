import 'package:flutter_bloc/flutter_bloc.dart';

class SectionLayoutCubit extends Cubit<bool> {
  /// Cubit to change the state of the switch and toggle the layout
  SectionLayoutCubit() : super(true);

  void toggleLayout() => emit(!state);
}
