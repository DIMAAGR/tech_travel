import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  final String profilePhotoURL = 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg';
}
