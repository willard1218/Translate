# -*- coding: utf-8 -*-  
import requests
from bs4 import BeautifulSoup
import json

url = 'https://www.ted.com/talks/majora_carter_s_tale_of_urban_renewal/transcript?language=zh-tw'
# url = 'https://www.ted.com/talks/majora_carter_s_tale_of_urban_renewal/transcript?language=en'
title = url.split('/')[4]
r = requests.get(url)
soup = BeautifulSoup( r.text.encode( r.encoding ), "lxml" )
paragraphs = soup.findAll("span", {"class": "talk-transcript__para__text"})

paragraphsObj = []
for paragraph in paragraphs:
  sentencesObj = []
  for child in paragraph.children:
    sentenceObj = {}
    if child.name == 'span':
      text = child.text
      dataTime = child["data-time"]
      sentenceObj["text"] = text.encode('utf8')
      sentenceObj["time"] = int(dataTime)
      sentencesObj.append(sentenceObj)

  paragraphsObj.append(sentencesObj)

article = {"title":title, "url" : url, "paragraphs" : paragraphs}

print len(paragraphsObj)
with open('result2.json', 'w') as fp:
  json.dump(paragraphsObj, fp, ensure_ascii=False, indent=4)
