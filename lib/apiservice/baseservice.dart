
abstract class BaseService {
  Future<dynamic> getResponse(String url);
  Future<dynamic> getResponseDirect(String url, Map<String, String> headers);
  Future<dynamic> postResponse(String url, var body);

  Future<dynamic> putResponse(String url, var body);
  Future<dynamic> deleteResponse(String url,var body);
  // Future<dynamic> DeleteResponse(String url, var headers, var body);
  Future<dynamic> patchResponse(String url, var body);
}