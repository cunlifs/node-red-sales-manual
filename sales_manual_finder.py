#!/usr/bin/env python
# coding: utf-8

from urllib.request import urlopen
from bs4 import BeautifulSoup
import json
import sys

MTM = sys.argv[1]
# MTM = "9080-MME"
Search_url = "https://www-01.ibm.com/common/ssi/FetchJSON.wss?ctype=DD%3ADDSM&ctry=EUR%3AGB&lang=&MPPEFFTR=DOCNO&MPPEFSCH="
Search_url += MTM
Search_url += "&MPPEFFDR=&MPPEFTDR=&MPPEFSRT=2&hitsperpage=20&resultpage=1"

html = urlopen(Search_url)
soup = BeautifulSoup(html, 'html')
# soup.content
json_string = soup.text
parsed_json = json.loads(json_string)
results = parsed_json['totalhitscount']
if results == 0:
    print ("Missing")
else:
    Result_url = " https://www-01.ibm.com"
    Result_url += parsed_json['hitList'][0]['url']
    print (Result_url)
exit()
