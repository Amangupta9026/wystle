import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';

 const awsRegion = "eu-west-2";
    const awsBucketId = "wystle";
    final AwsS3Client awsS3client = AwsS3Client(
        region: awsRegion,
        host: "s3.eu-west-2.amazonaws.com",
        bucketId: awsBucketId,
        accessKey: "AKIAQ4UXMACGEPN4A7EK",
        secretKey: "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");

class AWSService {
  
  // static Future<Uint8List?> fetchAWS3Image(String posterImage) async {
  //   const region = "eu-west-2";
  //   const bucketId = "wystle";
  //   final AwsS3Client s3client = AwsS3Client(
  //       region: region,
  //       host: "s3.eu-west-2.amazonaws.com",
  //       bucketId: bucketId,
  //       accessKey: "AKIAQ4UXMACGEPN4A7EK",
  //       secretKey: "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");
  //   final listBucketResult = await s3client.listObjects(
  //       prefix: "Wystle/Admin/rider-app/on-boarding/login-flash",
  //       delimiter: "/");
  //   final response = await s3client.getObject(posterImage);
  //   // setState(() {
  //   final Uint8List _base64 = response.bodyBytes;
  //   // });
  //   return _base64;
  // }
}
