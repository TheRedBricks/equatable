int mapListPropsToHashCode(List props) {
  int hashCode = 0;

  props.forEach((prop) {
    int propHashCode = prop.hashCode;
    if (prop is Map<String, dynamic>) {
      propHashCode = mapPropsToHashCode(prop);
    }
    if (prop is List) {
      propHashCode = mapListPropsToHashCode(prop);
    }
    hashCode = hashCode ^ propHashCode;
  });

  return hashCode;
}

int mapPropsToHashCode(Map<String, dynamic> props) {
  int hashCode = 0;

  props.forEach((key, prop) {
    int propHashCode = prop.hashCode;
    if (prop is Map<String, dynamic>) {
      propHashCode = mapPropsToHashCode(prop);
    }
    if (prop is List) {
      propHashCode = mapListPropsToHashCode(prop);
    }
    hashCode = hashCode ^ propHashCode;
  });

  return hashCode;
}

bool equalsList(List list1, List list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  int length = list1.length;
  if (length != list2.length) return false;
  for (int i = 0; i < length; i++) {
    if (list1[i] is Map<String, dynamic> && list2[i] is Map<String, dynamic>) {
      if (!equals(
          list1[i] as Map<String, dynamic>, list2[i] as Map<String, dynamic>))
        return false;
    } else if (list1[i] is List && list2[i] is List) {
      if (!equalsList(list1[i] as List, list2[i] as List)) return false;
    } else {
      if (list1[i] != list2[i]) return false;
    }
  }
  return true;
}

bool equals(Map<String, dynamic> list1, Map<String, dynamic> list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  int length = list1.length;
  if (length != list2.length) return false;
  final keys = list1.keys;
  for (var key in keys) {
    if (list1[key] is Map<String, dynamic> &&
        list2[key] is Map<String, dynamic>) {
      if (!equals(list1[key] as Map<String, dynamic>,
          list2[key] as Map<String, dynamic>)) return false;
    } else if (list1[key] is List && list2[key] is List) {
      if (!equalsList(list1[key] as List, list2[key] as List)) return false;
    } else {
      if (list1[key] != list2[key]) return false;
    }
  }
  return true;
}
