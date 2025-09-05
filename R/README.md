nivaPhytoPlanktonR
=========================

- Query the Phytoplankton schema in Oracle database.
- Use WFS to download data from Geoserver cloud.
- Use Aquamonitor API to download water chemistry and Phytoplankton index data.


## Installation

To install the package, you can use the `devtools` package:

```R
# install.packages("devtools")
devtools::install_github("NIVANorge/niva-phyto-plank/R/nivaPhytoPlanktonR")
```
## Usage

### Connection and user context

One user context object that holds connection details for the different data sources.
Keep on to username after input, but avoid keeping password in a variable.
Instead keep on to connection objects returned, or tokens returned from Aquamonitor API.

```R
library(nivaPhytoPlanktonR)
# Example: Querying the Phytoplankton schema
cnx <- UserContext()
```

### Phytoplankton data using query function

```R
df <- pp_query(cnx, "SELECT * FROM t_Lakes")
head(df)
```


### Light integration with Aquamonitor through AquaCounter API

To have the match between station's in Phytoplankton and stations in Nivadatabase / Aquamonitor, use the function `aqm_station_ids()`.
This function takes a context object and a vector of Phytoplankton stationid's, and returns a vector of corresponding Nivadatabase station_id's.

It can take advantage of either Oracle connection to Phytoplankton schema, or use Aquamonitor API directly.

```cmd
curl -u "xxx:xxxxxxxxxxx" https://aquamonitor.niva.no/AquaCounter/api/catcounter/plankton
```

```R
stids <- aqm_station_ids(cnx, c(12345, 67890))
```

### Download water chemistry data from Aquamonitor

This is using the library aquamonitR to download data from Aquamonitor API.
Very little flexibility is added in this package, but it's using the AquaCache API to download data.

We're creating wrapper functions that mimic the functions with the same name in aquamonitR, but adding the user context as first argument and leaving token out. As that is handled by the user context.


### Fetching GIS data from Geoserver WFS to prepare maps

Different approaches are possible. Phytoplankton stations are linked to lakes which have a vannforekomstid attached. That could be used for fetching lake polygons from miljodir_innsjovannforekomster_f.

Another approach is to use the coordinates of either the Phytoplankton stations or the Nivadatabase stations to do a spatial query against the same layer. It's also possible to use nve_innsjo_f, as not all lakes have a vannforekomstid.
