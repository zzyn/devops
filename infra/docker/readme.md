# dockerfiles
node images


#Tencent Hub CRC Image Push
https://cloud.tencent.com/document/product/457/9117#create

## Node:12.16.1 + Alpine + Sonaqube-Scanner
### ImageName:node12_sonarqube_scanner:1.0.0
```bash
sh docker-build.sh -i node12_sonarqube_scanner:1.0.0
```
### TencentHubImage:
```bash
docker tag [ImageId] ccr.ccs.tencentyun.com/xxxx/node12_sonarqube_scanner:1.0.0
docker push ccr.ccs.tencentyun.com/xxxx/node12_sonarqube_scanner:1.0.0
```