import 'MediaDTO.dart';

class ListWithMediaDTO {
  final int listId;
  final String listName;
  final String listType;
  List<MediaDTO> mediaDTOList;

  ListWithMediaDTO({
    required this.listId,
    required this.listName,
    required this.listType,
    required this.mediaDTOList
  });

  void setMediaDTOList(mediaDTOList){
    this.mediaDTOList = mediaDTOList;
  }

  factory ListWithMediaDTO.fromJson(Map<String, dynamic> json){
    return ListWithMediaDTO(
        listId: json['listId'],
        listName: json['listName'],
        listType: json['listType'],
        mediaDTOList: loadMediaDTOs(json)
    );
  }

  static List<MediaDTO> loadMediaDTOs(json){
    var mediaDTOList = List.from(json['mediaDTOList']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return MediaDTO.fromJson(item);
      }
    }).toList();

    return mediaDTOList.whereType<MediaDTO>().toList();
  }

}