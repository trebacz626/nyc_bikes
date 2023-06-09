import os
import json
import pandas as pd
from tqdm import tqdm
def combine_json_to_csv(folder_path, output_filename):
    # initialize a list to store DataFrames
    all_data = []

    # iterate through all json files in the folder
    for filename in tqdm(os.listdir(folder_path)):
        if filename.endswith('.json'):
            with open(os.path.join(folder_path, filename), 'r') as f:
                data = json.load(f)

            # check if 'data' and 'stations' fields are in the json
            if 'data' in data and 'stations' in data['data']:
                # convert the json to a DataFrame and add it to all_data list
                stations_df = pd.json_normalize(data['data']['stations'])
                all_data.append(stations_df)

    # concatenate all the dataframes in the list
    all_data = pd.concat(all_data, ignore_index=True)

    print("Length before dropping duplicates: ", len(all_data))
    # drop duplicates
    all_data = all_data.drop_duplicates(subset=['station_id', 'last_reported'])
    print("Length after dropping duplicates: ", len(all_data))

    # save the DataFrame to a CSV file
    all_data.to_csv(output_filename, index=False)

if __name__ == '__main__':
    folder_path = '../data/station_status/renamed'  # replace this with your folder path
    output_filename = '../data/station_status/combined_status.csv'  # replace this with your output filename
    combine_json_to_csv(folder_path, output_filename)
