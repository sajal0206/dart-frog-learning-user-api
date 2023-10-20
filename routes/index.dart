import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  if (context.request.method == HttpMethod.get) {
    return Response(body: 'This is a get method');
  } else if (context.request.method == HttpMethod.post) {
    return Response(body: 'This POST request on index!');
  } else {
    return Response(
      body: '${context.request.method.name} method is not allowed',
    );
  }
}
