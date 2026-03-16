import '../data/repositories/songs/song_repository_mock.dart';
import '../data/repositories/songs/song_repository.dart';
import '../model/songs/song.dart';

 void main() async {
  //   Instantiate the  song_repository_mock
    SongRepository repository = SongRepositoryMock();
    print("Finding the Song by ID...");
  
 
  // Test both the success and the failure of the post request
 
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  repository.fetchSongById("1").then((song) {
        print("Song Received: ${song?.title}");
      }).catchError((error) {
        print("Error: $error");
      });
  
  // - Using async/await with try/catch.
  try {
    Song? song = await repository.fetchSongById("s1"); 
    print("Song Received: ${song?.title}");
  } catch (e) {
    print("Error: $e");
  }


  }