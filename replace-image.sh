#set -e

image=v1.30.0-alpha.2-dirty

echo -e "\nRedeploy kube-scheduler..."
mv /etc/kubernetes/manifests/kube-scheduler.yaml /tmp

#make sure the new built image will be used
while [[ $(crictl ps | grep scheduler) ]]; do
    echo "Scheduler is still running"
    sleep 2
done

crictl rmi docker.io/axiang99/kube-scheduler:$image

#restore
cp /tmp/kube-scheduler.yaml  /etc/kubernetes/manifests/
echo "Wait for scheduler pod to run..."

count=0
while [[ $count -lt 4 ]]; do
    result=`crictl ps | grep scheduler`
    if [[ -n "$result" ]]; then
        echo "Scheduler is running"
        break
    else
        echo "Scheduler is not running, waiting..."
        sleep 5
        ((count++))
    fi
done
