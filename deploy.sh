docker build -t rishi0209/multi-client:latest -t rishi0209/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rishi0209/multi-server:latest -t rishi0209/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rishi0209/multi-worker:latest -t rishi0209/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rishi0209/multi-client:latest
docker push rishi0209/multi-server:latest
docker push rishi0209/multi-worker:latest

docker push rishi0209/multi-client:$SHA
docker push rishi0209/multi-server:$SHA
docker push rishi0209/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rishi0209/multi-server:$SHA
kubectl set image deployments/client-deployment client=rishi0209/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rishi0209/multi-worker:$SHA