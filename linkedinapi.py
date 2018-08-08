# -*- coding: utf-8 -*-
"""
Created on Tue Aug  7 20:58:24 2018

@author: aditya royal
"""

from linkedin import linkedin
KEY = '781kklombog4fn'
SECRET = 'rVm2siK5NYp3DBjQ'

RETURN_URL = 'http://localhost:8080'

authentication = linkedin.LinkedInAuthentication(KEY,
                                                 SECRET,
                                                 RETURN_URL,
                                                 permissions=['r_basicprofile'])

print(authentication.authorization_url)
authentication.authorization_code='AQQWrZioeRhz4ljNo05Z2RXgproBFSo3wT2Vwd6A44Wuufg29qXUMFbJkUl9sTQjr-LqtO-jl2fcqfnCWCMojPdSxZQJZBrwx5wIvEIF4WKiAtbtlRV-ymgz118ZOEd6R2T4S2vHzmPUJh51JEl9NCTg-lmQbg'
token=authentication.get_access_token()
application = linkedin.LinkedInApplication(token=token)
application.get_companies(universal_names=['apple'], selectors=['name'], params={'is-company-admin': 'true'})
application.search_company(selectors=[{'companies': ['name', 'universal-name', 'website-url']}], params={'keywords': 'apple microsoft'})