import 'dart:convert' as convert;
import 'package:share_preference_demo/tools/local_storage_tool.dart';

extension JRUserLoacalData on JRLocalStorage {
  
  static void createUserListMap(Map userMap) {
    Map map = {'list': []};
    List list = map['list'];
    list.add(userMap);
    map['list'] = list;
    String jsonStr = convert.jsonEncode(map);
    JRLocalStorage.save('UserList', jsonStr);
  }

  static void updateUserListMap(String jsonString, Map userMap) {
    Map resMap = convert.jsonDecode(jsonString);
    List list = resMap['list'].toList();
    list.add(userMap);
    resMap['list'] = list;
    String jsonStr = convert.jsonEncode(resMap);
    print('jsonStr = $jsonStr');
    JRLocalStorage.save('UserList', jsonStr);
  }
  
  static void deleteUserFromUserListMap(String jsonString, int index) {
    Map userListMap = convert.jsonDecode(jsonString);
    List userList = userListMap['list'];
    userList.removeAt(index);
    userListMap['list'] = userList;
    String jsonStr = convert.jsonEncode(userListMap);
    print('删除后的UserListMap = $jsonStr');
    JRLocalStorage.save('UserList', jsonStr);
  }
}
