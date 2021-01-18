#!/bin/bash
scp ./deployment.sh root@192.168.50.148:/otp/
kubectl apply -f /otp/deployment.sh
