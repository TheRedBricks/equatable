import 'dart:convert';

import 'package:test/test.dart';
import 'package:equatable/equatable.dart';

class NonEquatable {}

class EquatableBase with EquatableMixinBase, EquatableMixin {}

class EmptyEquatable extends EquatableBase with EquatableMixin {}

class SimpleEquatable<T> extends EquatableBase with EquatableMixin {
  final T data;

  SimpleEquatable(this.data);

  @override
  Map<String, dynamic> get props => super.props..addAll({'data': data});
}

class MultipartEquatable<T> extends EquatableBase with EquatableMixin {
  final T d1;
  final T d2;

  MultipartEquatable(this.d1, this.d2);

  @override
  Map<String, dynamic> get props => super.props..addAll({'d1': d1, 'd2': d2});
}

class OtherEquatable extends EquatableBase with EquatableMixin {
  final String data;

  OtherEquatable(this.data);

  @override
  Map<String, dynamic> get props => super.props..addAll({'data': data});
}

enum Color { blonde, black, brown }

class ComplexEquatable extends EquatableBase with EquatableMixin {
  final String name;
  final int age;
  final List<String> children;

  ComplexEquatable({this.name, this.age, this.children});

  @override
  Map<String, dynamic> get props => super.props
    ..addAll({
      'name': name,
      'age': age,
      'children': children,
    });
}

class EquatableData extends EquatableBase with EquatableMixin {
  final String key;
  final dynamic value;

  EquatableData({this.key, this.value});

  @override
  Map<String, dynamic> get props => super.props..addAll({key: value});
}

class Credentials extends EquatableBase with EquatableMixin {
  final String username;
  final String password;

  Credentials({this.username, this.password});

  @override
  Map<String, dynamic> get props => super.props
    ..addAll({
      'username': username,
      'password': password,
    });

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}

void main() {
  group('Empty Equatable', () {
    test('should correct toString', () {
      final instance = EmptyEquatable();
      expect(instance.toString(), "Instance of 'EmptyEquatable'");
    });

    test('should return true when instance is the same', () {
      final instance = EmptyEquatable();
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = EmptyEquatable();
      expect(instance.hashCode, instance.runtimeType.hashCode);
    });

    test('should return true when instances are different', () {
      final instanceA = EmptyEquatable();
      final instanceB = EmptyEquatable();
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = EmptyEquatable();
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (string)', () {
    test('should correct toString', () {
      final instance = SimpleEquatable('simple');
      expect(instance.toString(), '{\n  "data": "simple"\n}');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable('simple');
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable('simple');
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = SimpleEquatable('simple');
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when compared to different equatable', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = OtherEquatable('simple');
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable('simple');
      final instanceB = SimpleEquatable('Simple');
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (number)', () {
    test('should correct toString', () {
      final instance = SimpleEquatable(0);
      expect(instance.toString(), '{\n  "data": 0\n}');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(0);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(0);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = SimpleEquatable(0);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(0);
      final instanceB = SimpleEquatable(1);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (bool)', () {
    test('should correct toString', () {
      final instance = SimpleEquatable(true);
      expect(instance.toString(), '{\n  "data": true\n}');
    });

    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(true);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(true);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = SimpleEquatable(true);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(true);
      final instanceB = SimpleEquatable(false);
      expect(instanceA == instanceB, false);
    });
  });

  group('Simple Equatable (Equatable)', () {
    test('should correct toString', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instance.toString(), '{\n  "data": {\n    "foo": "bar"\n  }\n}');
    });
    test('should return true when instance is the same', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ instance.data.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'bar',
      ));
      final instanceB = SimpleEquatable(EquatableData(
        key: 'foo',
        value: 'barz',
      ));
      expect(instanceA == instanceB, false);
    });
  });

  group('Multipart Equatable', () {
    test('should correct toString', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(instance.toString(), '{\n  "d1": "s1",\n  "d2": "s2"\n}');
    });
    test('should return true when instance is the same', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = MultipartEquatable("s1", "s2");
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.d1.hashCode ^
            instance.d2.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = MultipartEquatable("s1", "s2");
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = MultipartEquatable("s1", "s2");
      final instanceB = MultipartEquatable("s2", "s1");
      expect(instanceA == instanceB, false);

      final instanceC = MultipartEquatable("s1", "s1");
      final instanceD = MultipartEquatable("s2", "s1");
      expect(instanceC == instanceD, false);
    });
  });

  group('Complex Equatable', () {
    test('should correct toString', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      expect(instance.toString(),
          '{\n  "name": "Joe",\n  "age": 40,\n  "children": [\n    "Bob"\n  ]\n}');
    });
    test('should return true when instance is the same', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.name.hashCode ^
            instance.age.hashCode ^
            instance.children[0].hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = ComplexEquatable(
        name: 'Joe',
        age: 40,
        children: ['Bob'],
      );
      final instanceB = ComplexEquatable(
        name: 'John',
        age: 40,
        children: ['Bobby'],
      );
      expect(instanceA == instanceB, false);
    });
  });

  group('Json Equatable', () {
    test('should correct toString', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instance.toString(),
          '{\n  "username": "Admin",\n  "password": "admin"\n}');
    });

    test('should return true when instance is the same', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instance == instance, true);
    });

    test('should return correct hashCode', () {
      final instance = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^
            instance.username.hashCode ^
            instance.password.hashCode,
      );
    });

    test('should return true when instances are different', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instanceA == instanceB, true);
      expect(instanceA.hashCode == instanceB.hashCode, true);
    });

    test('should return false when compared to non-equatable', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = NonEquatable();
      expect(instanceA == instanceB, false);
    });

    test('should return false when values are different', () {
      final instanceA = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"admin"
        }
        """,
      ) as Map<String, dynamic>);
      final instanceB = Credentials.fromJson(json.decode(
        """
        {
          "username":"Admin",
          "password":"password"
        }
        """,
      ) as Map<String, dynamic>);
      expect(instanceA == instanceB, false);
    });
  });
}
