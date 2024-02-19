#set -e

echo -e "\nLoad image..."
out=`docker load -i _output/release-images/amd64/kube-scheduler.tar`

version=`echo "$out" | awk -F: '{print $3}'`
image=v1.30.0-alpha.2-dirty

echo -e "\nLoad done: $version. Push image $image to dockerhub..."
docker tag registry.k8s.io/kube-scheduler-amd64:$version axiang99/kube-scheduler:$image
docker push axiang99/kube-scheduler:$image

