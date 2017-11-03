```
# setup
docker network create local
docker run -d --net local --name registry registry
docker build -t buildkit_http .
docker run -d --net local -p 8080:8080 --privileged buildkit_http

# prepare request tar
cat > config <<EOT                                                                                                        !10161
{"Ref": "registry.local:5000/foo/bar:latest"}
EOT
mkdir context
cat > context/Dockerfile <<EOT                                                                                            !10161
FROM busybox
ADD Dockerfile /
ENV foo bar
EOT
tar cvf req.tar .

# query
curl -i 192.168.10.98:8080/build -X POST --data-binary @req.tar
```