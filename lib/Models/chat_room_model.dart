class ChatRoomModel{
  String? chatRooId;
  List<String>? participants;

  ChatRoomModel({this.chatRooId,this.participants});

  ChatRoomModel.fromMap(Map<String,dynamic> map){
    chatRooId=map["chatRoomId"];
    participants =map["participants"];
  }
  Map<String,dynamic> toMap(){
    return {
      "chatRoomId":chatRooId,
      "participants":participants
    };
  }

}