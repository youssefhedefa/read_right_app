sealed class AppManagerState{
  final int viewIndex;
  AppManagerState({required this.viewIndex});
}

class AppManagerBottomNavBarIndexState extends AppManagerState{
  @override
  final int viewIndex;
  AppManagerBottomNavBarIndexState({required this.viewIndex}) : super(viewIndex: viewIndex);
}

