#!/bin/bash
./start.sh
curl -k https://localhost:8443/humanres/control/emplPositionView?emplPositionId=DEMO100
./done.sh
