class DataUtils {
  final Map data;
  const DataUtils(this.data);

  dynamic fromData(String key, {dynamic defaultValue}) =>
      data[key] != null ? data[key] : defaultValue;
}
