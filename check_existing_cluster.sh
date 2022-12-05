CHECK_NAME=$(aws eks list-clusters | jq -r ".clusters" | grep duypk5_udacity || true)
if ["$CHECK_NAME" !=""]; then 
    echo "There is already a cluster by this name"
else
    eksctl create cluster --name duypk5-udacity --region us-east-1
fi

