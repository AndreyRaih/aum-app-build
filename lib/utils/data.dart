class DataExtractor {
  final Map data;
  const DataExtractor(this.data);

  dynamic getValue(String key, {dynamic defaultValue}) => data[key] != null ? data[key] : defaultValue;
}

String makeUniqueFileNameFromBasket(String name) => "$name-${DateTime.now().millisecondsSinceEpoch.toString()}";

String normalizeAsanaName(String base) => (base[0].toUpperCase() + base.substring(1)).replaceAll('_', ' ');
