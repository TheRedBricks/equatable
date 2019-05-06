int mapPropsToHashCode(Map<String, dynamic> props) {
  int hashCode = 0;

  props.forEach((key, prop) {
    final propHashCode =
        prop is Map<String, dynamic> ? mapPropsToHashCode(prop) : prop.hashCode;
    hashCode = hashCode ^ propHashCode;
  });

  return hashCode;
}

bool equals(Map<String, dynamic> list1, Map<String, dynamic> list2) {
  if (identical(list1, list2)) return true;
  if (list1 == null || list2 == null) return false;
  int length = list1.length;
  if (length != list2.length) return false;
  for (int i = 0; i < length; i++) {
    if (list1[i] is Map<String, dynamic> && list2[i] is Map<String, dynamic>) {
      if (!equals(
          list1[i] as Map<String, dynamic>, list2[i] as Map<String, dynamic>))
        return false;
    } else {
      if (list1[i] != list2[i]) return false;
    }
  }
  return true;
}
