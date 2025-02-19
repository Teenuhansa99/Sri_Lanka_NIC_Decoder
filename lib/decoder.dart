import 'package:intl/intl.dart';

Map<String, String>? decodeNIC(String nic) {
  //check the NIC is in the old or new format.
  if (nic.length == 10 || nic.length == 12) {
    String birthYear;
    int days;
    String nicType =
        nic.length == 10 ? 'Old NIC' : 'New NIC'; //determine the NIC type.

    //extract birth year and days based on NIC format.
    if (nic.length == 10) {
      birthYear = '19${nic.substring(0, 2)}';
      days = int.parse(nic.substring(2, 5));
    } else {
      birthYear = nic.substring(0, 4);
      days = int.parse(nic.substring(4, 7));
    }

    //determine gender based on the days value.
    String gender = days < 500 ? 'Male' : 'Female';
    if (days > 500) days -= 500; //adjust day count for females.

    //calculate the exact birth date.
    String birthDate = _calculateDate(int.parse(birthYear), days);
    DateTime birthDateObj =
        DateFormat('yyyy-MM-dd').parse(birthDate); //convert to DateTime.

    //calculate age based on the current date.
    DateTime now = DateTime.now();
    int age = now.year - birthDateObj.year;

    //if the birthday hasn't occurred yet this year, subtract 1 from age.
    if (now.month < birthDateObj.month ||
        (now.month == birthDateObj.month && now.day < birthDateObj.day)) {
      age--;
    }

    //get weekday
    String weekday = DateFormat('EEEE').format(birthDateObj);

    //return details
    return {
      ' NIC Type': nicType,
      ' Birth Year': birthYear,
      ' Birth Date': birthDate,
      ' Age': age.toString(),
      ' Weekday': weekday,
      ' Gender': gender,
    };
  }

  return null;
}

String _calculateDate(int year, int days) {
  DateTime dob = DateTime(year, 1, 1).add(Duration(days: days - 2));

  return DateFormat('yyyy-MM-dd').format(dob);
}
