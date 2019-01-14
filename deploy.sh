docker build -t noufgo/multi-client:latest -t noufgo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t noufgo/multi-server:latest -t noufgo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t noufgo/multi-worker:latest -t noufgo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push noufgo/multi-client:latest
docker push noufgo/multi-server:latest
docker push noufgo/multi-worker:latest

docker push noufgo/multi-client:$SHA
docker push noufgo/multi-server:$SHA
docker push noufgo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=noufgo/multi-client:$SHA
kubectl set image deployments/server-deployment server=noufgo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=noufgo/multi-worker:$SHA