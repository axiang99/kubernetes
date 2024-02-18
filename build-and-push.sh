echo "making..."
make quick-release

echo "push image to dockerhub..."
docker load -i _output/release-images/amd64/kube-scheduler.tar
sleep 5
docker tag registry.k8s.io/kube-scheduler-amd64:v1.30.0-alpha.1-dirty  axiang99/kube-scheduler:v1.30.0-alpha.1-dirty
docker push axiang99/kube-scheduler:v1.30.0-alpha.1-dirty
sleep 5

echo "redeplo kube-scheduler..."
mv /etc/kubernetes/manifests/kube-scheduler.yaml /tmp
sleep 5
cp /tmp/kube-scheduler.yaml  /etc/kubernetes/manifests/
