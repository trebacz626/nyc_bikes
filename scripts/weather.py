import argparse
import os
import requests
import pandas as pd
def get_url(start_date, end_date):
    return f"https://archive-api.open-meteo.com/v1/archive?latitude=40.71&longitude=-74.01&start_date={start_date}&end_date={end_date}&hourly=temperature_2m,relativehumidity_2m,dewpoint_2m,apparent_temperature,precipitation,rain,snowfall,weathercode,cloudcover,windspeed_10m,winddirection_10m,windgusts_10m"

def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--dest", help="Destination location", required=False, default=os.path.realpath(os.path.dirname(__file__)) + "/weather.csv")
    parser.add_argument("--from_date", help="From date", required=True, default=None)
    parser.add_argument("--to_date", help="To date", required=True, default=None)
    args= parser.parse_args()
    dest = args.dest
    url = get_url(args.from_date, args.to_date)
    #get json
    response = requests.get(url)
    #parse json to dict
    data = response.json()['hourly']
    df = pd.DataFrame(data)
    #save to csv
    df.to_csv(dest, index=False)









if __name__ == "__main__":
    main()
