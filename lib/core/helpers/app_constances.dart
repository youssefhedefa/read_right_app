import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/features/home/data/models/categories_model.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_state.dart';

abstract class AppConstances{
  static List<CategoriesModel> categories = [
    CategoriesModel(
      arName: "كل الكتب",
      enName: "All Books",
      viewState: BooksCategoriesStateEnum.allBooks,
      image: AppImageHelper.litreCategory,
      numberOfBooks: [0],
    ),
    CategoriesModel(
      arName: "أدب الأطفال",
      enName: "Children's Literature",
      viewState: BooksCategoriesStateEnum.childrenLitre,
      image: AppImageHelper.litreCategory,
      numberOfBooks: [1,2,3],
    ),
    CategoriesModel(
      arName: "حكمة",
      enName: "Fable",
      viewState: BooksCategoriesStateEnum.fable,
      image: AppImageHelper.folkCategory,
      numberOfBooks: [4,5,6,7,8,9],
    ),
    CategoriesModel(
      arName: "حكاية شعبية",
      enName: "Folktale",
      viewState: BooksCategoriesStateEnum.folk,
      image: AppImageHelper.folkCategory,
      numberOfBooks: [10],
    ),
    CategoriesModel(
      arName: "مغامرة",
      enName: "Adventure",
      viewState: BooksCategoriesStateEnum.adven,
      image: AppImageHelper.advenCategory,
      numberOfBooks: [11,12,13,14],
    ),
    CategoriesModel(
      arName: "رياضة",
      enName: "Sports",
      viewState: BooksCategoriesStateEnum.sports,
      image: AppImageHelper.sportsCategory,
      numberOfBooks: [15,16,17,18,19],
    ),
    CategoriesModel(
      arName: "علم",
      enName: "Science",
      viewState: BooksCategoriesStateEnum.science,
      image: AppImageHelper.scienceCategory,
      numberOfBooks: [20,21,22,23],
    ),
  ];
}