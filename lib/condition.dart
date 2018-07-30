import 'package:rule_engine/fact.dart';

import 'nodes/node.dart';
import 'nodes/comparison_node.dart';

class Condition {
  Node _lhs;
  ComparisonNode _comparisonNode;
  Node _rhs;

  Condition(this._lhs, this._comparisonNode, this._rhs);

  bool evaluateCondition(
      Map<String, dynamic> symbolTable, List<Fact> facts, Map<String, dynamic> clauseTable, Fact fact) {
    num lvalue =
        num.parse(_lhs.getValue(symbolTable, facts, fact) ?? _lhs.getValue(clauseTable, facts, fact), (s) {}) ?? 0;
    num rvalue =
        num.parse(_rhs.getValue(symbolTable, facts, fact) ?? _rhs.getValue(clauseTable, facts, fact), (s) {}) ?? 0;
    switch (_comparisonNode.operation) {
      case "<":
        return lvalue < rvalue;
      case ">":
        return lvalue > rvalue;
      case "<=":
        return lvalue <= rvalue;
      case ">=":
        return lvalue >= rvalue;
      case "==":
        return 0 ==
            (_lhs.getValue(symbolTable, facts, fact) ?? _lhs.getValue(clauseTable, facts, fact))
                .compareTo(_rhs.getValue(symbolTable, facts, fact) ?? _rhs.getValue(clauseTable, facts, fact));

      default:
    }

    return false;
  }

  String toString() {
    return "{Condition: ${_lhs.getName()} ${_comparisonNode.getName()} ${_rhs.getName()} }";
  }
}
