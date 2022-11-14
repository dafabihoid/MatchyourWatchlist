class ListDTO {
   final String WatchlistName;
   final int Id;

    ListDTO({
      required this.WatchlistName,
      required this.Id,
});


}

class ErikApi {
   static final ErikApiListe = [
      ListDTO(
          WatchlistName: "Test1", Id: 10),
      ListDTO(WatchlistName: "Test2", Id: 20),
     ListDTO(WatchlistName: "Test3", Id: 30),
     ListDTO(WatchlistName: "Test4", Id: 40),
     ListDTO(WatchlistName: "Test5", Id: 50),
     ListDTO(WatchlistName: "Test6", Id: 60),
     ListDTO(WatchlistName: "Test7", Id: 70),
   ];
}