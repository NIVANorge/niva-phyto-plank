# niva-phyto-plank

This is a repository for the Freshwater Phytoplankton domain at NIVA. The main purpose is to provide tools and a database for counting phytoplankton in water samples. The main tool is called CatCounter.

## Links

[CatCounter GitHub Repository](https://github.com/NIVANorge/CatCounter)

In addition CatCounter is using AquaMonitor API at:

[AquaMonitor API](https://aquamonitor.niva.no/AquaCounter/)

And geo data from NIVAGIS:

[Geoserver](https://geoserver.p.niva.no/)

## User credentials

The user credentials for the different sources are stored in a secure file. Both at the users computer as well as in the cloud. In the cloud it will be hidden behind the users Azure AD credentials.

The different sources are:

- AquaMonitor
- Nivagis (Geoserver)
- Nivabase (Oracle)

### AquaMonitor and Geoserver

For AquaMonitor and Geoserver we use the usual AquaMonitor token. This has an expiration date and could be invalidated by changing the password.

### Nivabase

For Nivabase we use personal credentials. The password must be set in Oracle and USIT has a policy of changing the password at regular intervals. We will encrypt the password and store it in the user credentials file. Maybe with an expiration date. Part of the user administation will be to grant the users access to the cc_user role.

### Geoserver

At Geoserver we would like to have a single Workspace for all users. So part of the User credentials administration would be to handle which users are allowed to use that workspace.
