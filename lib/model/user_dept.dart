class UserDebt {
  String _team;
  bool _isMaster;
  int _totalPayment = 0;
  int _totalDebt = 0;
  String _currencyType = "";

  String get team => _team;

  set team(String value) {
    _team = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'team': _team,
      'isMaster': _isMaster,
      'totalDebt': _totalDebt,
      'totalPayment': _totalPayment,
      'currencyType': _currencyType
    };
  }

  UserDebt.fromMap(Map<String, dynamic> map)
      : _team = map['team'],
        _isMaster = map['isMaster'],
        _totalDebt = map['totalDebt'],
        _totalPayment = map['totalPayment'],
        _currencyType = map['currencyType'];

  bool get isMaster => _isMaster;

  String get currencyType => _currencyType;

  set currencyType(String value) {
    _currencyType = value;
  }

  int get totalDebt => _totalDebt;

  set totalDebt(int value) {
    _totalDebt = value;
  }

  int get totalPayment => _totalPayment;

  set totalPayment(int value) {
    _totalPayment = value;
  }

  set isMaster(bool value) {
    _isMaster = value;
  }
}
