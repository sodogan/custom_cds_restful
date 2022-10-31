@EndUserText.label: 'KemeraCompletionDec Geoms'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_KEMERACOMPDEC_GEOMS_HAND'

@Search.searchable: true
@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION

@UI.headerInfo: {
  typeName: 'KemeraCompletionDec',
  typeNamePlural: 'KemeraCompletionDecs',
  title: {  label: 'KemeraCompletionDecs'}
}
define custom entity ZC_KEMERA_COMPDEC_GEOMS
{
      @UI.facet                      : [ 
                   { id              :       'Geoms',
                     purpose         :         #STANDARD,
                     type            :            #IDENTIFICATION_REFERENCE,
                     label           :           'Geometries',
                     position        :        10
                     }
                 ]

      @UI                            : {
         lineItem                    : [ { position: 10 } ],
         identification              : [ { position: 10, importance: #HIGH, type: #STANDARD } ],
         selectionField              : [ { position: 10 } ]
         }
      @EndUserText.quickInfo         : 'Stand Reference'
      @EndUserText.label             : 'Stand Reference'
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
  key standreference                 : zstandreference;

      @UI                            : {
      lineItem                       : [ { position: 20 } ],
      identification                 : [ { position: 20, importance: #HIGH, type: #STANDARD } ],
      selectionField                 : [ { position: 20 } ]
      }
      @EndUserText.quickInfo         : 'Financing Act Number'
      @EndUserText.label             : 'Financing Act No'
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
   key   financingactnumber             : zfinactnumber;
      @UI                            : {
      lineItem                       : [ { position: 30 } ],
      identification                 : [ { position: 30, importance: #HIGH, type: #STANDARD } ],
      selectionField                 : [ { position: 30 } ]
      }
      @EndUserText.quickInfo         : 'Stand Number'
      @EndUserText.label             : 'Stand Number'
      standnumber : abap.string;
      @UI                            : {
      lineItem                       : [ { position: 40 } ],
      identification                 : [ { position: 40, importance: #HIGH, type: #STANDARD } ]
      }
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
      @EndUserText.quickInfo         : 'Geo JSON'
      @EndUserText.label             : 'Geo JSON'
      geojson                         : abap.string;
      @UI                            : {
      lineItem                       : [ { position: 50 } ],
      identification                 : [ { position: 50, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'Status'
      @EndUserText.label             : 'Status'
      status                       : abap.string;

      @UI                            : {
      lineItem                       : [ { position: 60 } ],
      identification                 : [ { position: 60, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'Stand number Extension'
      @EndUserText.label             : 'Stand number Extension'
      standnumberextension                      : abap.string;

      @UI                            : {
      lineItem                       : [ { position: 70 } ],
      identification                 : [ { position: 70, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'Cost Type'
      @EndUserText.label             : 'Cost Type'
      costtype                        : abap.string;

     
     _KemeraCompletionDecs     : association to parent ZC_KEMERA_COMPLETION_DEC on $projection.financingactnumber = _KemeraCompletionDecs.financingactnumber;




}
