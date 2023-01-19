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