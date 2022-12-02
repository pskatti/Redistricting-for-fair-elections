import pandas as pd
import json as js
import xlsxwriter
from urllib.request import Request, urlopen

file = open('countyList.json', 'r')
county_list = js.load(file)
file.close()
row = []
row1 = []
row2 = []
row3 = []
row4 = []
for i in county_list["countyList"]:
	row.append([i['cnm'], i['bct'], i['rtl'], i['bpt'], i['ptl']])
	row1.append([i['cnm']])
	row2.append([i['cnm']])
	row3.append([i['cnm']])
	row4.append([i['cnm']])

# df = pd.DataFrame(row, columns = ['CountyName', 'BallotsCast', 'OutOf', 'Turnout', 'No.OfPrecincts'])
# df.to_excel('Turnout.xlsx')

for n in range(101):
	#for 2020
	#url="https://er.ncsbe.gov/enr/20201103/data/results_"+str(n)+".txt"
	#for 2018
	url="https://er.ncsbe.gov/enr/20181106/data/results_"+str(n)+".txt"
	req = Request(url, headers={'User-Agent': 'Mozilla/83.0'})
	web_byte = urlopen(req).read()
	webpage = web_byte.decode('utf-8')
	data = js.loads(webpage)
	entry = []

	districts = ["US HOUSE OF REPRESENTATIVES DISTRICT 01 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 02 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 03 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 04 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 05 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 06 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 07 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 08 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 09 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 10 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 11 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 12 (VOTE FOR 1)", "US HOUSE OF REPRESENTATIVES DISTRICT 13 (VOTE FOR 1)"]
	entryDcount = [0,0,0,0,0,0,0,0,0,0,0,0,0]
	entryDpercent = [0,0,0,0,0,0,0,0,0,0,0,0,0]
	entryRcount = [0,0,0,0,0,0,0,0,0,0,0,0,0]
	entryRpercent = [0,0,0,0,0,0,0,0,0,0,0,0,0]
	for i in data:
		name = i['cnm']
		if name in districts:
			# entryDcount[0] = entryDpercent[0] = entryRcount[0] = entryRpercent[0] = name
			index = int(name[38:40])-1
			if i['pty'] == "DEM":
				entryDcount[index] = i['vct']
				entryDpercent[index] = i['pct']
			elif i['pty'] == "REP":
				entryRcount[index] = i['vct']
				entryRpercent[index] = i['pct']
	row1[n].extend(entryDcount)
	row2[n].extend(entryDpercent)
	row3[n].extend(entryRcount)
	row4[n].extend(entryRpercent)
df1 = pd.DataFrame(row1, columns = ['CountyName', "US HOUSE OF REPRESENTATIVES DISTRICT 01", "US HOUSE OF REPRESENTATIVES DISTRICT 02", "US HOUSE OF REPRESENTATIVES DISTRICT 03", "US HOUSE OF REPRESENTATIVES DISTRICT 04", "US HOUSE OF REPRESENTATIVES DISTRICT 05", "US HOUSE OF REPRESENTATIVES DISTRICT 06", "US HOUSE OF REPRESENTATIVES DISTRICT 07", "US HOUSE OF REPRESENTATIVES DISTRICT 08", "US HOUSE OF REPRESENTATIVES DISTRICT 09", "US HOUSE OF REPRESENTATIVES DISTRICT 10", "US HOUSE OF REPRESENTATIVES DISTRICT 11", "US HOUSE OF REPRESENTATIVES DISTRICT 12", "US HOUSE OF REPRESENTATIVES DISTRICT 13"])
df2 = pd.DataFrame(row2, columns = ['CountyName', "US HOUSE OF REPRESENTATIVES DISTRICT 01", "US HOUSE OF REPRESENTATIVES DISTRICT 02", "US HOUSE OF REPRESENTATIVES DISTRICT 03", "US HOUSE OF REPRESENTATIVES DISTRICT 04", "US HOUSE OF REPRESENTATIVES DISTRICT 05", "US HOUSE OF REPRESENTATIVES DISTRICT 06", "US HOUSE OF REPRESENTATIVES DISTRICT 07", "US HOUSE OF REPRESENTATIVES DISTRICT 08", "US HOUSE OF REPRESENTATIVES DISTRICT 09", "US HOUSE OF REPRESENTATIVES DISTRICT 10", "US HOUSE OF REPRESENTATIVES DISTRICT 11", "US HOUSE OF REPRESENTATIVES DISTRICT 12", "US HOUSE OF REPRESENTATIVES DISTRICT 13"])
df3 = pd.DataFrame(row3, columns = ['CountyName', "US HOUSE OF REPRESENTATIVES DISTRICT 01", "US HOUSE OF REPRESENTATIVES DISTRICT 02", "US HOUSE OF REPRESENTATIVES DISTRICT 03", "US HOUSE OF REPRESENTATIVES DISTRICT 04", "US HOUSE OF REPRESENTATIVES DISTRICT 05", "US HOUSE OF REPRESENTATIVES DISTRICT 06", "US HOUSE OF REPRESENTATIVES DISTRICT 07", "US HOUSE OF REPRESENTATIVES DISTRICT 08", "US HOUSE OF REPRESENTATIVES DISTRICT 09", "US HOUSE OF REPRESENTATIVES DISTRICT 10", "US HOUSE OF REPRESENTATIVES DISTRICT 11", "US HOUSE OF REPRESENTATIVES DISTRICT 12", "US HOUSE OF REPRESENTATIVES DISTRICT 13"])
df4 = pd.DataFrame(row4, columns = ['CountyName', "US HOUSE OF REPRESENTATIVES DISTRICT 01", "US HOUSE OF REPRESENTATIVES DISTRICT 02", "US HOUSE OF REPRESENTATIVES DISTRICT 03", "US HOUSE OF REPRESENTATIVES DISTRICT 04", "US HOUSE OF REPRESENTATIVES DISTRICT 05", "US HOUSE OF REPRESENTATIVES DISTRICT 06", "US HOUSE OF REPRESENTATIVES DISTRICT 07", "US HOUSE OF REPRESENTATIVES DISTRICT 08", "US HOUSE OF REPRESENTATIVES DISTRICT 09", "US HOUSE OF REPRESENTATIVES DISTRICT 10", "US HOUSE OF REPRESENTATIVES DISTRICT 11", "US HOUSE OF REPRESENTATIVES DISTRICT 12", "US HOUSE OF REPRESENTATIVES DISTRICT 13"])

writer = pd.ExcelWriter('HORTurnout2018.xlsx', engine='xlsxwriter')

df1.to_excel(writer, sheet_name = 'Sheet1')
df2.to_excel(writer, sheet_name = 'Sheet2')
df3.to_excel(writer, sheet_name = 'Sheet3')
df4.to_excel(writer, sheet_name = 'Sheet4')
writer.save()
	# horentry = ["", "", "", "", ""]
	# dem = []
	# rep = []
	# for i in data:
	# 	name = i['cnm']
	# 	if name == "US PRESIDENT (VOTE FOR 1)" and i['pty'] == "DEM":
	# 		dem.append(i['vct'])
	# 		dem.append(i['pct'])
	# 	if name == "US PRESIDENT (VOTE FOR 1)" and i['pty'] == "REP":
	# 		rep.append(i['vct'])
	# 		rep.append(i['pct'])

	# row[n].extend(dem)
	# row[n].extend(rep)

# df = pd.DataFrame(row, columns = ['CountyName', 'BallotsCast', 'OutOf', 'Turnout', 'No.OfPrecincts', 'DEM-PRES-VOTES', 'DEM-PRES-PERCENT', 'REP-PRES-VOTES', 'REP-PRES-PERCENT'])
# df.to_excel('Turnout.xlsx')
		#name =  name[:9]
		# if name == "US HOUSE":
		# 	if len(horentry) == 0:
		# 		horentry[0] =i['cnm']
		# 	if i['pty'] == "DEM":
		# 		horentry[1] = i['vct']
		# 		horentry[2] = i['pct']
		# 	elif i['pty'] == "REP":
		# 		horentry[1] = i['vct']
		# 		horentry[2] = i['pct']
