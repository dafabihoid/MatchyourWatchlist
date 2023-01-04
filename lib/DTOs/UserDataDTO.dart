class UserDataDTO {
  final String userId;
  late String userName;
  final String userAccountName;

  UserDataDTO({
    required this.userId,
    required this.userName,
    required this.userAccountName
  });

  factory UserDataDTO.fromJson(Map<String, dynamic> json){
    return UserDataDTO(
        userId: json['userId'],
        userName: json['userName'],
        userAccountName: json['userAccountName']
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'userAccountName': userAccountName,
  };

}