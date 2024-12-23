enum AppRoute {
  tree('/tree'),
  editor('/editor');

  const AppRoute(this.path);

  final String path;
}
