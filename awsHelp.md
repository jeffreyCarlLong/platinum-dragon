## AWS Help

### File Transfer

aws s3 cp --profile profReference localPath s3://bucketName/dataAssetNumber/[ExptType]/[ProductType]/ --sse --recursive

.aws/conf
[profReference]
secretKey secretKey
publicKey publicKey
region us-west-1

