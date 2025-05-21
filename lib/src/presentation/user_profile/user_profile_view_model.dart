import 'package:mobx/mobx.dart';

part 'user_profile_view_model.g.dart';

class UserProfileViewModel = UserProfileViewModelBase with _$UserProfileViewModel;

abstract class UserProfileViewModelBase with Store {
  final String profilePhotoURL = 'https://i.pinimg.com/736x/ac/33/56/ac33563b6de9253a779883dca00a5692.jpg';
}
