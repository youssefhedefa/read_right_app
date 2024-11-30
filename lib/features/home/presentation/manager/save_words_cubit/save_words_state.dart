abstract class SaveWordsState{}

class SaveWordsInitial extends SaveWordsState{}

class SaveWordsLoading extends SaveWordsState{}

class SaveWordsSuccess extends SaveWordsState{}

class SaveWordsFailure extends SaveWordsState{
  final String message;

  SaveWordsFailure({required this.message});
}