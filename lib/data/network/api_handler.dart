part of 'api.dart';

abstract class ApiHandler{
  Future get(String url);
  Future post(String url, dynamic body);
  Future put(String url, dynamic body);
  Future delete(String url);

  factory ApiHandler() => _ApiHandlerImpl();
}

class _ApiHandlerImpl implements ApiHandler{
  dynamic _process(http.Response response){
    switch(response.statusCode){
      case 200:
      case 400:
      case 401:
      case 403:
      case 404:
        return jsonDecode(response.body.toString());
      case 500:
      default:
        return FetchDataException(
          'Error occurred while connecting to server with StatusCode : ${response.statusCode}',
        );
    }
  }


  @override
  Future delete(String url)async {
   try{
     final response = await http.delete(Uri.parse(url));
     return _process(response);
   } on SocketException{
     throw FetchDataException('No internet Connection');
   }
  }

  @override
  Future get(String url)async {
    try{
      final response = await http.get(Uri.parse(url));
      return _process(response);
    } on SocketException{
      throw FetchDataException('No internet Connection');
    }
  }

  @override
  Future post(String url, body)async{
    try{
      final response = await http.post(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException{
      throw FetchDataException('No internet Connection');
    }
  }

  @override
  Future put(String url, body)async {
    try{
      final response = await http.put(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException{
      throw FetchDataException('No internet Connection');
    }
  }
  
}