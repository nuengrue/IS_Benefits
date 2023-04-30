
import 'dart:convert';
import 'package:ghb_benefits/htttpTest/post_modal.dart';
import 'package:http/http.dart';


class Service {
  List<Post> mydata = [];
    // List<ChildAllowaneModel> dataChildAllowane = [];

   Future<List<Post>?> getPosts() async {
        Client client = Client();
    
    
    final res = await client.get(Uri.parse(
      'http://localhost:5000/SQL/Execute',
    ));

    if(res.statusCode == 200) {
      var ds = jsonDecode(res.body);
      return ds;
    }

   }

   Future<List<Post>> fetchPosts() async {
            Client client = Client();
   final response = await client.get(Uri.parse(
      'http://localhost:5000/SQL/Execute',
    ));
  var responseJson = json.decode(response.body);
  print(responseJson["data"]);
  for (var ls in responseJson["data"]) {
   mydata.add(Post.fromJson(ls));
    print(mydata);
  }
 // print(responseJson);
 return mydata;
}
//    Future<List<ChildAllowaneModel>> fetchChildAllowaneModel() async {
//             Client client = Client();
//    final response = await client.get(Uri.parse(
//       'http://localhost:5000/SQL/GetChildAllowance',
//     ));
//   var responseJson = json.decode(response.body);
//   print(responseJson["data"]);
//   for (var ls in responseJson["data"]) {
//    dataChildAllowane.add(ChildAllowaneModel.fromJson(ls));
//     print(dataChildAllowane);
//   }
//  // print(responseJson);
//  return dataChildAllowane;
// }
}
