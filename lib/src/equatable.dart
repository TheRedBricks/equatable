import 'dart:convert';

import './equatable_utils.dart';

/// A class that helps implement equality
/// without needing to explicitly override == and [hashCode].
/// Equatables override their own == and [hashCode] based on
/// the provided `properties`.
abstract class Equatable {
  /// The [Map<String,dynamic>] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  final Map<String, dynamic> props;

  /// The constructor takes an optional [Map<String,dynamic>] of `props` (properties) which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// an empty [Map<String,dynamic>].
  Equatable([this.props = const {}]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          equals(props, other.props);

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  String toString() => props.isNotEmpty
      ? JsonEncoder.withIndent('  ').convert(props)
      : super.toString();

  Map<String, dynamic> toJson() => props;
}
