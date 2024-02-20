#set -e

image=v1.30.0-alpha.2-dirty

echo -e "\nRedeploy kube-scheduler..."
mv /etc/kubernetes/manifests/kube-scheduler.yaml /tmp

echo -n "Waiting for Scheduler to stop..."
while [[ $(kubectl get pod  -n kube-system | grep sche) ]]; do
    sleep 2
    echo -n "."
done

#make sure the new built image will be used
sellp 5
crictl rmi docker.io/axiang99/kube-scheduler:$image
rm -f /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler/*.log

#restore
sleep 5
cp /tmp/kube-scheduler.yaml  /etc/kubernetes/manifests/
echo -n "Waiting for Scheduler to run..."

count=0
while [[ $count -lt 6 ]]; do
    result=`crictl ps | grep scheduler`
    if [[ -n "$result" ]]; then
        echo -e "\nScheduler is running."
        break
    else
        echo -n "."
        sleep 5
        ((count++))
    fi
done
