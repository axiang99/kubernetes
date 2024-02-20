echo "$0  <dest-log-folder>"

if [[ $# -lt 1 ]]; then
    exit 1
fi

log_dest=$1 

echo "Log: /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler"
cd /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler

echo -e "\nLines of 'Update event for node'\n"
grep 'Update event for node'  *

echo -e "\nLines of GWX:\n"
grep GWX -C 1 * 

echo -e "\n\n"

echo -e "Lines of hint:\n"
grep hint *

echo -e "\nLines of pod:\n"
grep nginx *

echo -e "\nBackup full kube-scheduler log to $log_dest:\n"
if [ ! -d "$log_dest" ]; then
  mkdir -p "$log_dest"
fi

cp /var/log/pods/kube-system_kube-scheduler-node-10-158-36-43_*/kube-scheduler/*.log  $log_dest/
ls -l $log_dest

cd -
