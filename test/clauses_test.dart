import 'package:rule_engine/fact.dart';
import 'package:rule_engine/rule_engine.dart';
import 'package:test/test.dart';

void _basicTest() {
  String code = r"""
rule "weekly saver"
  when
      SimpleFact( amount > 10 )
  then
      publish Achievement( "test" )
end
""";
  var ruleEngine = new RuleEngine(code);

  var results = new List();
  ruleEngine.registerListener((t, a) {
    results.add(t);
  });

  ruleEngine.insertFact(new SimpleFact("Bob", 11, new DateTime.now()));
  expect(results.length, equals(1));

  ruleEngine.insertFact(new SimpleFact("Bob", 12, new DateTime.now()));
  expect(results.length, equals(2));
}

void main() {
  test('Basic test: insertion of facts', _basicTest);
}

class SimpleFact extends Fact {
  String _name;
  int _amount;
  DateTime _created;

  SimpleFact(this._name, this._amount, this._created);

  @override
  Map<String, dynamic> attributeMap() {
    Map<String, dynamic> attributes = new Map<String, dynamic>();
    attributes["name"] = _name;
    attributes["amount"] = _amount;
    attributes["created"] = _created;
    return attributes;
  }

  @override
  String toString() {
    return "$_name: $_amount $_created";
  }
}
