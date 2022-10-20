// import '../models/jwt_token.dart';

// /// JWT Token Validator
// class JWTTokenValidator {
//   /// JWT Token from Authentication
//   JWTToken token;

//   JWTTokenValidator({required this.token});

//   /// Verify JWT Token
//   bool isVerified() {
//     try {
//       JWTToken jwtToken = JWTToken.parse(token.token);
//       DateTime now = DateTime.now();
//       DateTime expired =
//           DateTime.fromMillisecondsSinceEpoch(jwtToken.exp * 1000);

//       /// Compare the Expiration Date and Now in Minutes
//       int diffInMinutes = now.difference(expired).inMinutes;
//       return (diffInMinutes < 0) ? true : false;
//     } catch (_) {
//       return false;
//     }
//   }
// }
