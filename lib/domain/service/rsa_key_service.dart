import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class RSAKeyService {
  late AsymmetricKeyPair<PublicKey, PrivateKey> keyPair;

  RSAKeyService() {
    final keyGen = RSAKeyGenerator();
    keyGen.init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
      SecureRandom('Fortuna')..seed(KeyParameter(Uint8List(32))),
    ));
    keyPair = keyGen.generateKeyPair();
  }

  // String getPublicKeyPem() {
  //   final publicKey = keyPair.publicKey as RSAPublicKey;
  //   final encoder = ASN1Encoder();
  //   encoder.add(publicKey.modulus!);
  //   encoder.add(publicKey.exponent!);
  //   return base64Encode(encoder.encodedBytes);
  // }

  Signature sign(String data) {
    final privateKey = keyPair.privateKey as RSAPrivateKey;
    final signer = Signer('SHA-256/RSA');
    signer.init(
      true,
      PrivateKeyParameter<RSAPrivateKey>(privateKey),
    );
    return signer.generateSignature(Uint8List.fromList(utf8.encode(data)));
  }
}
