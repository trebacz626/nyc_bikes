import argparse
import os
import requests
import pandas as pd
def get_url():
    return "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"

def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--dest", help="Destination location", required=False, default="../data/stations/stations_data.csv")
    args= parser.parse_args()
    dest = args.dest
    url = get_url()
    #get json
    response = requests.get(url)
    #parse json to dict
    data = response.json()['data']['stations']
    df = pd.DataFrame(data)
    df = df[['name', 'region_id', 'lon', 'lat', 'electric_bike_surcharge_waiver', 'external_id', 'legacy_id', 'station_id', 'capacity', 'short_name', 'station_type', 'has_kiosk', 'eightd_has_key_dispenser']]
    #save to csv
    df.to_csv(dest, index=False)









if __name__ == "__main__":
    main()
