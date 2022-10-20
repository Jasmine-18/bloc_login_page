// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:jaguar_jwt/jaguar_jwt.dart';

// /// JWTToken
// class JWTToken extends Equatable {
//   String token;

//   String aud;
//   String jti;
//   int iat;
//   int nbf;
//   int exp;

//   JWTToken(
//       {required this.token,
//       required this.aud,
//       required this.jti,
//       required this.iat,
//       required this.nbf,
//       required this.exp});

//   @override
//   List<Object> get props => [token, exp];

//   @override
//   String toString() {
//     return token;
//   }

//   factory JWTToken.fromJson(Map<String, dynamic> data) {
//     String aud = (data['aud'] ?? "").toString();
//     String jti = (data['jti'] ?? "").toString();
//     int iat = int.parse((data['iat'] ?? 0).toString());
//     int nbf = int.parse((data['nbf'] ?? 0).toString());
//     int exp = int.parse((data['exp'] ?? 0).toString());

//     return JWTToken(aud: aud, jti: jti, iat: iat, nbf: nbf, exp: exp, token: '');
//   }

//   factory JWTToken.parse(String token) {
//     try {
//       final payloads = token.split('.');
//       final String decoded = B64urlEncRfc7515.decodeUtf8(payloads[1]);
//       return JWTToken.fromJson(jsonDecode(decoded));
//     } on JwtException catch (error) {
//       throw Exception(error);
//     } catch (error) {
//       throw Exception(error);
//     }
//   }
// }

// /// Response from Authorization API
// class TokenResponse extends Equatable {
//   String message;
//   JWTToken token;

//   TokenResponse({this.message, this.token});

//   @override
//   List<Object> get props => [message, token];

//   factory TokenResponse.fromJson(Map<String, dynamic> data) {
//     String message = (data['message'] ?? "").toString();

//     String accessToken = (data['access_token'] ?? "").toString();
//     JWTToken token = JWTToken(token: accessToken);

//     return TokenResponse(message: message, token: token);
//   }
// }
