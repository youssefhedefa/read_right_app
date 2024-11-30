import 'package:read_right/features/home/domain/entities/book_entity.dart';

// abstract class HomeDataState{}
//
// class HomeDataInitial extends HomeDataState{}
//
// class HomeDataLoading extends HomeDataState{}
//
// class HomeDataSuccess extends HomeDataState{
//   final List<BooksEntity> books;
//   HomeDataSuccess({required this.books});
// }
//
// class HomeDataFailure extends HomeDataState{
//   final String message;
//   HomeDataFailure({required this.message});
// }

enum RecommendationState{
  initial,
  loading,
  success,
  failure
}

enum NewestState{
  initial,
  loading,
  success,
  failure
}

class AppHomeDataState{
  final RecommendationState recommendationState;
  final NewestState newestState;
  final List<BooksEntity>? books;
  final String? message;

  AppHomeDataState({required this.recommendationState,required this.newestState ,this.books, this.message});

  AppHomeDataState copyWith({
    RecommendationState? recommendationState,
    NewestState? newestState,
    List<BooksEntity>? books,
    String? message
  }){
    return AppHomeDataState(
      recommendationState: recommendationState ?? this.recommendationState,
      newestState: newestState ?? this.newestState,
      books: books ?? this.books,
      message: message ?? this.message
    );
  }

}