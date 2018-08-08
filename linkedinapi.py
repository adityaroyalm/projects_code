# -*- coding: utf-8 -*-
"""
Created on Tue Aug  7 20:58:24 2018

@author: aditya royal
"""

from linkedin import linkedin
# Go to linkedin developers and get akey and secret by creating an app
KEY = '781kklombog4fn'
SECRET = 'rVm2siK5NYp3DBjQ'
# Enter a return url in your linkedin developers account and mention the same url in the code as well
RETURN_URL = 'http://localhost:8080'
#choose access for only basic profile in app and even in the code
authentication = linkedin.LinkedInAuthentication(KEY,
                                                 SECRET,
                                                 RETURN_URL,
                                                 permissions=['r_basicprofile'])
#print the url and you need to authenticate the app by signing in and you are redirected to a differnt url
print(authentication.authorization_url)
# copy the part from the redirected url which has code='******' and that is the authorization code
authentication.authorization_code='AQQWrZioeRhz4ljNo05Z2RXgproBFSo3wT2Vwd6A44Wuufg29qXUMFbJkUl9sTQjr-LqtO-jl2fcqfnCWCMojPdSxZQJZBrwx5wIvEIF4WKiAtbtlRV-ymgz118ZOEd6R2T4S2vHzmPUJh51JEl9NCTg-lmQbg'
# get a token
token=authentication.get_access_token()
application = linkedin.LinkedInApplication(token=token)
application.get_companies(universal_names=['apple'], selectors=['name'], params={'is-company-admin': 'true'})
application.search_company(selectors=[{'companies': ['name', 'universal-name', 'website-url']}], params={'keywords': 'apple microsoft'})
