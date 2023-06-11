import os
import zipfile
import datetime
from tqdm import tqdm

def extract_and_rename(zip_path, extract_path):
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        for member in tqdm(zip_ref.infolist()):
            # extract the file
            zip_ref.extract(member, extract_path)

            # get the last modification date
            last_edited = datetime.datetime(*member.date_time).strftime('%Y-%m-%d_%H-%M-%S')

            # generate the new file name and its path
            new_file_name = f'Station_status_{last_edited}{os.path.splitext(member.filename)[1]}'
            new_file_path = os.path.join(extract_path, new_file_name)

            # rename the file
            old_file_path = os.path.join(extract_path, member.filename)
            os.rename(old_file_path, new_file_path)


# usage
extract_and_rename('../data/station_status/raw_status.zip', '../data/station_status/renamed/')
