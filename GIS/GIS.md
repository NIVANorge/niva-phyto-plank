# GIS

Accessing data in Geoserver Cloud.

Innsjøvannforekomster - returned with these properties:

- vannforekomstid
- vannforekomstnavn
- naturlig_sterkt_modifisert
- okologisk_tilstand
- okologisk_presisjon
- okologisk_miljomal
- kjemisk_tilstand
- kjemisk_presisjon
- kjemisk_miljomal
- vanntype
- okoregion
- interkalibreringstype
- nasjonalvanntype

The geometry will be in UTM 33.

```
curl "https://geoserver.p.niva.no/wfs?service=WFS&version=2.0.0&request=GetFeature&typeNames=no.niva.public:miljodir_innsjovannforekomster_f&outputFormat=json"
```

Accessing a single feature with vannforekomstid:

```
curl "https://geoserver.p.niva.no/wfs?service=WFS&version=2.0.0&request=GetFeature&typeNames=no.niva.public:miljodir_innsjovannforekomster_f&outputFormat=json&srsName=EPSG:4326&cql_filter=vannforekomstid='002-141-L'"
```

To query stations with the geometry of a innsjøvannforekomst. You must authenticate, because the stations aren't public:
The query is slow because we're accessing all AquaMonitor stations through WFS.
```
curl -H "Content-type: application/xml" -u "xxxx:xxxxxxxxxx" -d @query-stations-with-vannforekomst-geom.xml https://geoserver.p.niva.no/wps
```
