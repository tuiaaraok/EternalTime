import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'watch_model.g.dart';

@HiveType(typeId: 1)
class WatchModel {
  @HiveField(0)
  Uint8List image;
  @HiveField(1)
  String brandName;
  @HiveField(2)
  String serialNumber;
  @HiveField(3)
  String series;
  @HiveField(4)
  String cost;
  @HiveField(5)
  String typeOfWatch;
  @HiveField(6)
  String mechanism;
  @HiveField(7)
  String strapType;
  @HiveField(8)
  String glassMaterial;
  WatchModel({
    required this.image,
    required this.brandName,
    required this.serialNumber,
    required this.series,
    required this.cost,
    required this.typeOfWatch,
    required this.mechanism,
    required this.strapType,
    required this.glassMaterial,
  });
}
