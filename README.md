# custom_cds_restful

# Build custom_cds views with composition from HANA layer the tables are going to be called via AMDP through ODATA to get the data

# Kemera completion declaration is the ROOT entity and it has Geometries

For Kemera completion declaration: ZC_KEMERA_COMPLETION_DEC(ROOT ENTITY)

# Kemera completion declaration geometries is a custom entity and linked with Kemera completion declaration with composition

For Kemera completion declaration geometries:ZC_KEMERA_COMPDEC_GEOMS

1- Custom CDS entities are created
Kemera completion declaration: ZC_KEMERA_COMPLETION_DEC
kemera decision geometries:ZC_KEMERA_COMPDEC_GEOMS

every kemera completon declartion can have many geometeries and the linking field is financingactnumber

these are linked via COMPOSITION based on the field

2-Table functions are created: Inorder to get the data HTTP-GET handlers needs to be implemented and they all need ti implement the interface

For Kemera completion declaration: ZGET_KEMERACOMPDECS_TF
For Kemera completion declaration geometries:ZGET_KEMERACOMPDEC_GEOMS_TF

3- And the handlers for these are:
Kemera completion declaration: zcl_kemeracompletiondecs_hand.abap
Kemera completion declaration geometries:zcl_kemeracompdec_geoms_hand.abap

4- Create a beahvior definition for the root entity

5-Create a behavior implementation

6- Create a service definition: ZSD_KEMERA_DECISIONS
7- Create a Service Binding for Odat v2: ZSB_KEMERA_DECISIONS

and you can query them
And from the sql console query the table function like this

GISDATA.KEMERACOMPLETIONDECLARATION
primary key FINANCINGACTNUMBER
foreign key

FINANCINGACTNUMBER
COMPLETIONDECLARATIONREFERENCE
DECISIONDATE
SENTDATE
STARTDATE
ENDDATE
WORKCODE

GISDATA.KEMERACOMPLDECLARGEOMETRY
primary key STANDREFERENCE
foreign key FINANCINGACTNUMBER

STANDREFERENCE
FINANCINGACTNUMBER
STANDNUMBER
GEOLOC
STATUS
STANDNUMBEREXTENSION
COSTTYPE

query ZGET_KEMERACOMPDECS_TF
p_where: financingactnumber = '11-2018-24014'

query ZGET_KEMERACOMPDEC_GEOMS_TF
p_where: financingactnumber = '11-2018-24014'

## to select on

GET KemeraCompletion Decs
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs?$filter=financingactnumber eq '11-2018-24014'

GET KemeraCompletionDecs with expand and filter
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs?$expand=to_Geometries&$filter=financingactnumber eq '11-2018-24014'

GET KemeraCompletion DecsGeoms
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs('11-2018-24014')/to_Geometries

or single

https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/geometries('M-G20190000007208KMR')

POST request to create a new kemeracompletiondec
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs
and request body:
{
"financingactnumber":"99-2018-24014",
"completiondeclarationreference":"123",
"decisiondate":"2018-10-21",
"sentdate":"2018-08-21",
"startdate":"2018-09-21",
"enddate":"2018-10-21",
"workcode":"99"
}

PUT KemeraCompletionDecs
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs('99-2018-24014')
request body:
{
"completiondeclarationreference":"123",
"decisiondate":"2018-01-21",
"sentdate":"2018-02-21",
"startdate":"2018-03-21",
"enddate":"2018-04-21",
"workcode":"19"
}

Sample GOJSON
"geojson":"[ { \"geometry\": { \"coordinates\": [ [ [ 281267.961, 6965423.381 ], [ 281267.989, 6965416.778 ], [ 281269.351, 6965410.707 ], [ 281277.289, 6965397.677 ], [ 281267.961, 6965423.381 ] ] ], \"type\": \"Polygon\" } } ]"

POST New KemeraCompletionDec GEOMS
https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/KemeraCompletionDecs('11-2018-24014')/to_Geometries

request body:
{
"standreference": "M-G20190000007211KMR",
"standnumber": "2018-10-21",
"geojson": "[ { \"geometry\": { \"coordinates\": [ [ [ 281267.961, 6965423.381 ], [ 281267.989, 6965416.778 ], [ 281269.351, 6965410.707 ], [ 281277.289, 6965397.677 ], [ 281267.961, 6965423.381 ] ] ], \"type\": \"Polygon\" } } ]",
"status": "1",
"standnumberextension": "29",
"costtype": "99"
}

PUT KemeraCompletionDec GEOMS

https://mgrciwsd.sap.mgr.ads:44300/sap/opu/odata/sap/ZSB_KEMERACOMPLETION_DECS/geometries(standreference='M-G20190000007211KMR',financingactnumber='11-2018-24014')

request body:{
"standnumber": "2018-11-14",
"geojson": "[ { \"geometry\": { \"coordinates\": [ [ [ 281267.961, 6965423.381 ], [ 281267.989, 6965416.778 ], [ 281269.351, 6965410.707 ], [ 281277.289, 6965397.677 ], [ 281267.961, 6965423.381 ] ] ], \"type\": \"Polygon\" } } ]",
"status": "1",
"standnumberextension": "91",
"costtype": "12"
}
