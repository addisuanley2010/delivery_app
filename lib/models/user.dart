class Users {
  final String uid;

  Users({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;

  UserData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.address,
      required this.phone});
}
