// ignore_for_file: non_constant_identifier_names

class User {
  final String first_name;
  final String last_name;
  final DateTime date_of_birth;
  final Subscription subscription;
  final String password;

  User(this.first_name, this.last_name, this.date_of_birth, this.subscription, this.password);
}
class Subscription {
  final String type;
  final DateTime expiration_date;

  Subscription(this.type, this.expiration_date);
}
class Users {
  static final barbara = User(
    "Barbara",
    "Weinsein",
    DateTime(1983, 6, 7),
    Subscription("silver", DateTime(2025, 6, 29)),
    "ga83s6"
    );
  static final michael = User(
    "Michael", 
    "Franco",
    DateTime(2005, 9, 30),
    Subscription("bronze", DateTime(2025, 6, 21)),
    "9x7zih"
    );
}
