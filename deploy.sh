docker build -t rishi0209/multi-client:lastest -t rishi0209/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t rishi0209/multi-server:lastest -t rishi0209/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rishi0209/multi-worker:lastest -t rishi0209/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rishi0209/multi-client:lastest
docker push rishi0209/multi-server:lastest
docker push rishi0209/multi-worker:lastest

docker push rishi0209/multi-client:$SHA
docker push rishi0209/multi-server:$SHA
docker push rishi0209/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rishi0209/multi-server:$SHA
kubectl set image deployments/client-deployment client=rishi0209/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rishi0209/multi-worker:$SHA