enum Flavor {
  dev,
  hom,
  prd,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'EventsTime (DEV)';
      case Flavor.hom:
        return 'EventsTime (HOM)';
      case Flavor.prd:
        return 'EventsTime';
      default:
        return 'title';
    }
  }

}
