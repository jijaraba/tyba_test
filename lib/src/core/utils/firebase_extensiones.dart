import 'package:cloud_firestore/cloud_firestore.dart';

extension ToMapX on DocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> toMap({
    bool hasPath = false,
    Map<String, dynamic>? fields,
  }) {
    final map = data();
    final path = <String, dynamic>{'path': reference.path};

    return <String, dynamic>{
      'id': id,
      ...?map,
      if (hasPath) ...path,
      ...?fields,
    };
  }
}