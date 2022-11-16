import 'package:chat_mat/models/RecentCallModel.dart';
import 'package:chat_mat/pages/home/Items/ContactItem.dart';

class RecentCallServices {
  List<RecentCallModel> get_recent_call() {
    List<RecentCallModel> contacts = [
      RecentCallModel(
          email: "mohammadghafoori@gmail.com",
          Time: "4",
          DateTime: "2:10 PM",
          Date: "2022/11/7"),
      RecentCallModel(
          email: "mohammadghafoori@gmail.com",
          Time: "4",
          DateTime: "1:10 AM",
          Date: "2022/11/5"),
      RecentCallModel(
          email: "mohammadghafoori@gmail.com",
          Time: "4",
          DateTime: "12:10 PM",
          Date: "2022/11/3"),
    ];
    return contacts;
  }
}
