set -e

echo "load image..."
docker load -i _output/release-images/amd64/kube-scheduler.tar
sleep 5

version=v1.30.0-alpha.2.1_cc307bbd0c7d42-dirty
image=v1.30.0-alpha.2-dirty

echo "push image to dockerhub..."
docker tag registry.k8s.io/kube-scheduler-amd64:$version axiang99/kube-scheduler:$image
docker push axiang99/kube-scheduler:$image
sleep 5

echo "redeploy kube-scheduler..."
mv /etc/kubernetes/manifests/kube-scheduler.yaml /tmp
sleep 5
cp /tmp/kube-scheduler.yaml  /etc/kubernetes/manifests/
