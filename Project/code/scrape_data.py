import requests
from bs4 import BeautifulSoup


for x in range(1,10):
	URL = 'https://er.ncsbe.gov/?election_dt=11/03/2020&county_id='+str(x)+'&office=FED&contest=1373'
	page = requests.get(URL)
	soup = BeautifulSoup(page.content, 'html.parser')
	results = soup.find(id='table_1373')
	print(results)
