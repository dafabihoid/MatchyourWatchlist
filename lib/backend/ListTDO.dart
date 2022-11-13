class ListTDO {
   final String WatchlistName;
   final int Id;

    ListTDO({
      required this.WatchlistName,
      required this.Id,
});


}

class ErikApi {
   static final ErikApiListe = [
      ListTDO(
          WatchlistName: "Test1", Id: 10),
      ListTDO(WatchlistName: "Test2", Id: 20),
     ListTDO(WatchlistName: "Test3", Id: 30),
     ListTDO(WatchlistName: "Test4", Id: 40),
     ListTDO(WatchlistName: "Test5", Id: 50),
     ListTDO(WatchlistName: "Test6", Id: 60),
     ListTDO(WatchlistName: "Test7", Id: 70),
   ];
}