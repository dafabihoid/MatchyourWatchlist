import 'package:watchlist/Singleton/AppData.dart';

class FriendsDTO{
  late String UserID;
  late String FriendID;
  late String Status;
  late String FriendUserName;
  late String FriendUserDisplayName;

  FriendsDTO({
    required this.UserID,
    required this.FriendID,
    required this.Status,
    required this.FriendUserName,
    required this.FriendUserDisplayName,
});

  void UpdateRequestList_add (){
   AppData appData = AppData();

   appData.friendsList.add(this);
   appData.friendrequests.remove(this);

 }
  void UpdateRequestList_deny (){
    AppData appData = AppData();

    appData.friendrequests.remove(this);

  }
  void UpdateRequestList_callback (){
    AppData appData = AppData();

    appData.sentRequests.remove(this);

  }

 void UpdateFriendList(){
   AppData appData = AppData();

   appData.friendsList.remove(this);
 }

 void UpdateSentRequestList( ){
   AppData appData = AppData();

   appData.sentRequests.add(this);
 }

  factory FriendsDTO.fromJson(Map<String,dynamic>json){
    return FriendsDTO(
        UserID: json['UserId'],
        FriendID: json['FriendId'],
        Status: json['Status'],
        FriendUserName: json['UserName'],
        FriendUserDisplayName: json['UserAccountName']
    );
  }

}