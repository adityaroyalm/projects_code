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
import pandas as pd
df=pd.read_csv('dataset.csv')
search=df.apply(lambda row: str(row['company_name'])+' '+str(row['location']),axis=1)
website_url=list()
def url_finder(search):
    for i in range(len(search)):
        l=application.search_company(selectors=[{'companies': ['name', 'website-url']}], params={'keywords': str(search[i])})
        try:
            website_url.append(l['companies']['values'][0]['websiteUrl'])
        except:
            print('there is an error with' +str(search[i]))
    return website_url

#https://api.linkedin.com/v1/company-search:(companies:(id,website-url))?keywords=microsoft&oauth2_access_token=AQWcyv8eL-O3gemSWN_o-sR13zBM97HrDUItairZ-zMvOfZhgTrKCjwC4TxoYf6UC3a1_EXT1nGvp-sskSm97oKAHsNZ1TJFYNjthp3nx0GUqgn4CzjFEzI_-ACzfvZgT5GRxhD_6DS-_UOkXsxPKkaozedB3eFSky6LkTayEy0VXt0cplGOnwZRr0uwqS5Xrmh6F9Z_tQbk_9j1C_MrwCZjmOQ9bVTJVUXudSNMka7tiHRL-c-Fu0jaUqDyLj26t9FD9a2B4vJtErEfKhsgHShE7M6E0Fm8YY_47WMn5pIjp5TYMOAwx_9U2wZ28--8N2J3y69TYL57vxhI20nY9mvND6xmhg&format=json