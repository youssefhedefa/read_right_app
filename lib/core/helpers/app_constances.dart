import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/features/home/data/models/categories_model.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_state.dart';

abstract class AppConstances {
  static List<CategoriesModel> categories = [
    CategoriesModel(
      arName: "كل الكتب",
      enName: "All Books",
      viewState: BooksCategoriesStateEnum.allBooks,
      image: AppImageHelper.litreCategory,
      numberOfBooks: [100, 101, 102, 103, 104, 105, 106, 107, 108, 10001, 10002, 10003, 10004, 10005, 10006],
    ),
    CategoriesModel(
      arName: "أدب الأطفال",
      enName: "Children's Literature",
      viewState: BooksCategoriesStateEnum.childrenLitre,
      image: AppImageHelper.litreCategory,
      numberOfBooks: [ 102, 103, 104, 105, 106, 107, 108, 10002, 10003, 10005, 10006],
    ),
    CategoriesModel(
      arName: "حكمة",
      enName: "Fable",
      viewState: BooksCategoriesStateEnum.fable,
      image: AppImageHelper.folkCategory,
      numberOfBooks: [100, 106, 10003, 10005],
    ),
    CategoriesModel(
      arName: "حكاية شعبية",
      enName: "Folktale",
      viewState: BooksCategoriesStateEnum.folk,
      image: AppImageHelper.folkCategory,
      numberOfBooks: [102, 104, 105, 106, 108, 10001, 10002, 10003, 10005],
    ),
    CategoriesModel(
      arName: "مغامرة",
      enName: "Adventure",
      viewState: BooksCategoriesStateEnum.adven,
      image: AppImageHelper.advenCategory,
      numberOfBooks: [101, 102, 103, 105, 107, 10001, 10004],
    ),
    // CategoriesModel(
    //   arName: "رياضة",
    //   enName: "Sports",
    //   viewState: BooksCategoriesStateEnum.sports,
    //   image: AppImageHelper.sportsCategory,
    //   numberOfBooks: [],
    // ),
    // CategoriesModel(
    //   arName: "علم",
    //   enName: "Science",
    //   viewState: BooksCategoriesStateEnum.science,
    //   image: AppImageHelper.scienceCategory,
    //   numberOfBooks: [],
    // ),
  ];
}
