list="kube-apiserver kube-controller-manager kube-proxy kube-scheduler"

for c in `echo $list`; do

	echo -e "\nLoad image $c..."
	out=`docker load -i _output/release-images/amd64/$c.tar`

	version=`echo "$out" | awk -F: '{print $3}'`
	image=v1.32.0-alpha.2-dirty

	echo -e "\nLoad done: $version. Push image $c:$image to dockerhub..."
	docker tag registry.k8s.io/$c-amd64:$version axiang99/$c:$image
	docker push axiang99/$c:$image

done
