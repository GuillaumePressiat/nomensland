import gzip
import json
import pandas
import pprint

# https://stackoverflow.com/a/39451012

def get_table(nom_table):
	with gzip.GzipFile("/home/gui/Documents/github/nomensland/inst/tables/" + nom_table + ".json.gz", 'r') as json_file:
		data = json.loads(json_file.read().decode('utf-8'))
	d =  pandas.DataFrame(data)
	return(d)

#print(get_table('ccam_actes').head(10))


def get_liste(nom_liste):
	with open("/home/gui/Documents/github/nomensland/inst/listes/" + nom_liste + ".json") as json_file:  
		data = json.load(json_file)
	return(data)

