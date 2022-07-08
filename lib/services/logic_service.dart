import 'package:crossplat_objectid/crossplat_objectid.dart';

String generateId() {
  ObjectId id1 = ObjectId();
  return id1.toHexString();
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}