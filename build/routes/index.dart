import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final data = context.read<String>();
  if (context.request.method == HttpMethod.get) {
    return Response(body: data);
  } else if (context.request.method == HttpMethod.post) {
    return Response(body: 'This POST request on index!');
  } else {
    return Response(
      body: '${context.request.method.name} method is not allowed',
    );
  }
}
