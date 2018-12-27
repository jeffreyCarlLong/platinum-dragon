## AWS Help

### File List from AWS Directory

aws s3 ls s3://pathToFiles/ | grep coord | grep -v met | rev | cut -f 1 -d " " | rev > fileList.txt

### File Transfer

aws s3 cp --profile profReference localPath s3://bucketName/dataAssetNumber/[ExptType]/[ProductType]/ --sse --recursive

.aws/conf
[profReference]
secretKey secretKey
publicKey publicKey
region us-west-1

