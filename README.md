# Fishing Report
This is not a working application at this time, feel free to open a pull request to participate

## Goals
- [X] Obtain fishing reports in an automated fashion from the State of California's DFG Stocking Report here -> https://nrm.dfg.ca.gov/FishPlants/ (click the "Export" button near the bottom of the page)
- [ ] We will need to import the data in a database, for Geo location features, at this time it doesnt matter whether its SQL, NoSQL, Redis or Elasticsearch (im strongly leaning toward elasticsearch right now), but because it will run on a cron task it will need to be running on a database which is always available.
- [ ] We will want to display the data on a geolocation aware map, we can probably use Elasticsearch + Kibana for this, which is the reason I think Elasticsearch might be the best option.
- [X] I think this should stay as a rake task for obtaining data, because then we can just add the task to crontab
- [ ] It might be nice to implement some features like automated email notifications when stocking reports are near favorite spots, or near home

## Dependencies
- Ruby 3.1.2 (can quickly be obtained from RVM)
- MongoDB Installed and Running

## Installation
```bash
$ make install
```

# Import Data

## Webscrape Fishing Report Data and import into Database
```bash
$ make run
```


# Display Data

## Run Elasticsearch
#### - to view the data in a user interface, you will need elasticsearch and kibana running.
#### - in a second tab, run the elasticsearch service
#### - follow the instructions in the terminal for configuring your session
```bash
$ make elasticsearch
```

## Run Kibana
##### - this will provide a graphical user interface to view map data
##### - in a third tab, run the kibana service and open browser to http://localhost:5601
```bash
$ make kibana
```
