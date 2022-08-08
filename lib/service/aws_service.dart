import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';

 const awsRegion = "eu-west-2";
    const awsBucketId = "wystle";
    final AwsS3Client awsS3client = AwsS3Client(
        region: awsRegion,
        host: "s3.eu-west-2.amazonaws.com",
        bucketId: awsBucketId,
        accessKey: "AKIAQ4UXMACGEPN4A7EK",
        secretKey: "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");

