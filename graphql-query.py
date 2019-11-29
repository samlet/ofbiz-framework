#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import requests
from urllib.parse import urlencode

with requests.Session() as s:
    r=s.get('https://localhost:8443/ofbizDemo/control/main/ajaxCheckLogin?USERNAME=admin&PASSWORD=ofbiz', verify=False)
    print(r.headers)

    print("✔ invoke java event ...")
    # visitUrl='https://localhost:8443/partymgr/control/FindCommunicationEvents'
    visitUrl='https://localhost:8443/ofbizDemo/control/graphqlEvent?'+urlencode(dict(query='{hello}'))
    r=s.get(visitUrl, verify=False)
    print("response code is "+str(r.status_code))
    print(r.text)

    print("✔ invoke groovy event ...")
    visitUrl='https://localhost:8443/ofbizDemo/control/graphqlScriptEvent?'+urlencode(dict(query='{hello}'))
    r=s.get(visitUrl, verify=False)
    print("response code is "+str(r.status_code))
    print(r.text)    


