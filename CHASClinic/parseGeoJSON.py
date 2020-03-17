import geojson
import xml.etree.ElementTree as ET

with open("chas-clinics-geojson.geojson") as f:
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

    

    table['latitude'] = feature['geometry']['coordinates'][0]
    table['longitude'] = feature['geometry']['coordinates'][1]

    allCHASTable = allCHASTable + table

for table in allCHASTable:
    print(table)


