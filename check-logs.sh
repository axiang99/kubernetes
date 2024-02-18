echo "Log: /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler"
cd /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler

echo -e "Lines of GWX:\n"
grep GWX -C 1 * 

echo -e "\n\n"

echo -e "Lines of hint:\n"
grep hint *


echo -e "\nLines of pod:\n"
grep nginx *

cd -
