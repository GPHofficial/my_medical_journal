import geojson
import xml.etree.ElementTree as ET

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from random import shuffle

# export GOOGLE_APPLICATION_CREDENTIALS="/home/gphofficial/dev/SE2006/my_medical_journal/CHASClinic/firestore-key.json"
firebase_admin.initialize_app()
db = firestore.client()



with open("chas-clinics/chas-clinics-geojson.geojson") as f:
    gj = geojson.load(f)

allCHASTable = []

for feature in gj['features']:
    properties = feature['properties']['Description']
    properties = properties.replace("&","&amp;")
    table = {}
    
    try:
        tableTree = ET.fromstring(properties)
        for row in tableTree.iter('tr'):
            column = None
            th = row.find('th')
            if th is not None:
                column = th.text

            td = row.find('td')
            if td is not None:
                table[column] = td.text
            elif column is not None:
                print(column)

    except:
        print("properties")

    

    table['LATITUDE'] = feature['geometry']['coordinates'][1]
    table['LONGITUDE'] = feature['geometry']['coordinates'][0]
    
    allCHASTable = allCHASTable + [table]

size = len(allCHASTable)


shuffle(allCHASTable)


count = 1
for i in range(len(allCHASTable)):
    table = allCHASTable[i]
    if(i%4==0):
        # print(table)
        db.collection(u'clinic').document(table['HCI_CODE']).set(table, merge=True)
    print(str(count) + " of " + str(size))
    count = count + 1


