import 'package:read_right/features/profile/domain/entities/profile_entity.dart';

enum ProfileDataStatus { initial, loading, success, logOut ,error }
enum SaveBookStatus { initial, loading, success, error }
class ProfileDataState {
  final ProfileDataStatus status;
  final SaveBookStatus saveBookStatus;
  final ProfileEntity? profileData;
  final List<dynamic>? bookList;
  final String? error;

  const ProfileDataState({
    this.status = ProfileDataStatus.initial,
    this.saveBookStatus = SaveBookStatus.initial,
    this.profileData,
    this.error,
    this.bookList,
  });

  ProfileDataState copyWith({
    ProfileDataStatus? status,
    SaveBookStatus? saveBookStatus,
    ProfileEntity? profileData,
    String? error,
    List<dynamic>? bookList,
  }) {
    return ProfileDataState(
      status: status ?? this.status,
      saveBookStatus: saveBookStatus ?? this.saveBookStatus,
      profileData: profileData ?? this.profileData,
      error: error ?? this.error,
      bookList: bookList ?? this.bookList,
    );
  }

}