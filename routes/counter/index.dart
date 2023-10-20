import 'package:dart_frog/dart_frog.dart';

int i = 0;
Response onRequest(RequestContext context) {
  i++;
  return Response(
    body: i.toString(),
  );
}
