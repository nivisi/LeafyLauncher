part of 'leafy_theme.dart';

typedef ThemeCreator<S extends LeafyTheme> = S Function({
  required Widget child,
});

HomeTheme _homeCreator(Widget child) {
  switch (LeafyTheme.currentStyle) {
    case LeafyThemeStyle.light:
      return HomeTheme.light(child);
    case LeafyThemeStyle.dark:
      return HomeTheme.dark(child);
    default:
      throw 'Unknown style';
  }
}

final _creatorMap = {
  HomeTheme: _homeCreator,
};
