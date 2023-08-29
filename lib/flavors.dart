enum Flavor {
  dev,
  hom,
  prd,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor ?? Flavor.dev) {
      case Flavor.dev:
        return 'EventsTime (DEV)';
      case Flavor.hom:
        return 'EventsTime (HOM)';
      case Flavor.prd:
        return 'EventsTime';
    }
  }

  static String get baseUrl {
    switch (appFlavor ?? Flavor.dev) {
      case Flavor.dev:
        return 'http://localhost:5000';
      case Flavor.hom:
        return 'http://192.168.100.82:5000';
      case Flavor.prd:
        return 'http://192.168.0.9:5000';
    }
  }
}
