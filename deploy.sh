docker build -t cheatcodesam/multi-client-k8s:latest -t cheatcodesam/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t cheatcodesam/multi-server-k8s-pgfix:latest -t cheatcodesam/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t cheatcodesam/multi-worker-k8s:latest -t cheatcodesam/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push cheatcodesam/multi-client-k8s:latest
docker push cheatcodesam/multi-server-k8s-pgfix:latest
docker push cheatcodesam/multi-worker-k8s:latest

docker push cheatcodesam/multi-client-k8s:$SHA
docker push cheatcodesam/multi-server-k8s-pgfix:$SHA
docker push cheatcodesam/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cheatcodesam/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=cheatcodesam/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=cheatcodesam/multi-worker-k8s:$SHA