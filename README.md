# xml2html
Experiments with transforming ISO, FGDC, and Dublin core metadata files into human-readable HTML using XSLT transforms in the browser

## Dependencies
* Magic XML - included

## Installation
* Install npm
* npm install -g http-server

Now start the dev server and go to 127.0.0.1:8080
```http-server .```

## Progress 
* So far the XSLT transforms are working in all major browsers including Android Chrome which is encouraging.  
 * ESRI FGDC works the best.  Needs testing with more records but seems to be the best supported.
 * ESRI ISO and ISO 2 (same xslt) work okay but the attribute labels are not being transformed to something readable.  It looks ESRI uses a multi-step process in which the XSLT does the intial transform and then their definition.xml and other files are used to complete the process.  These XSLT's would need to be updated to do the complete transform in one step. See the [ESRI wiki page](https://github.com/Esri/geoportal-server/wiki/Use-an-XSLT-to-Render-the-Details-Page) for more info.
 * Dublin core transform doesn't seem to work at all.

## Next Steps
Assuming the XSLT's could be enhanced and made consistent, the next step to plugging this in would be to:
* Create a new WCODP page with header and footer that given metadata type (iso, iso2, fgdc, dc, etc.) and metadata file (url) parameters on the URL it loads the XML file and applies the proper XSLT.  This would be a straightforward enhancement from where things are now.
* The WCODP results page should then be enhanced with a 'Metadata HTML' or simply 'Details' link that links to the new page and includes the necessary URL parameters
  * The metadata type can be derived from the SOLR search results for each record.  Specifically "sys.metadatatype.key_s": "iso19115-2".  The raw metadata URL as well which is already used for the Metadata XML link.
