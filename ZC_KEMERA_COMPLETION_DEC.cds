@EndUserText.label: 'KemeraCompletion Dec'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_KEMERACOMPLETIONDECS_HAND'

@Search.searchable: true
@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION

@UI.headerInfo: {
  typeName: 'KemeraCompletionDec',
  typeNamePlural: 'KemeraCompletionDecs',
  title: {  label: 'KemeraCompletionDecs'}
}
define root custom entity ZC_KEMERA_COMPLETION_DEC
{
      @UI.facet      : [ { id:           'kemeracompdecs',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'KemeraCompletionDecs',
                   position:        10 },
                   { id:              'Geoms',
                     purpose:         #STANDARD,
                     type:            #LINEITEM_REFERENCE,
                     label:           'Geometries',
                     position:        20,
                     targetElement:   '_Geometries'}
                 ]
      @UI            : {
      lineItem       : [ { position: 10 } ],
      identification : [ { position: 10, importance: #HIGH, type: #STANDARD } ],
      selectionField : [ { position: 10 } ]
      }
      @EndUserText.quickInfo         : 'Financing Act Number'
      @EndUserText.label             : 'Financing Act No'
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
  key financingactnumber     : zfinactnumber;
      @UI            : {
      lineItem       : [ { position: 20 } ],
      identification : [ { position: 20, importance: #HIGH, type: #STANDARD } ],
      selectionField : [ { position: 20 } ]
      }
      @EndUserText.quickInfo         : 'Completion Declaration Ref'
      @EndUserText.label             : 'Completion Declaration Ref'
      completiondeclarationreference       : abap.string;
      @UI            : {
      lineItem       : [ { position: 30 } ],
      identification : [ { position: 30, importance: #HIGH, type: #STANDARD } ]
      }
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
      @EndUserText.quickInfo         : 'Decision Date'
      @EndUserText.label             : 'Decision Date'
      decisiondate : abap.string;
      @UI            : {
      lineItem       : [ { position: 40 } ],
      identification : [ { position: 40, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'Sent Date'
      @EndUserText.label             : 'Sent Date'
      sentdate   : abap.string;

      @UI            : {
      lineItem       : [ { position: 50 } ],
      identification : [ { position: 50, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'Start Date'
      @EndUserText.label             : 'Start Date'
      startdate   : abap.string;
      
      @UI            : {
      lineItem       : [ { position: 60 } ],
      identification : [ { position: 60, importance: #HIGH, type: #STANDARD } ]
      }
      @EndUserText.quickInfo         : 'End Date'
      @EndUserText.label             : 'End Date'
      enddate   : abap.string;

      @UI            : {
      lineItem       : [ { position: 70 } ],
      identification : [ { position: 70, importance: #HIGH, type: #STANDARD } ],
      selectionField : [ { position: 70 } ]
      }
      @EndUserText.quickInfo         : 'Work Code'
      @EndUserText.label             : 'Work Code'
      workcode   : abap.string;

      
     _Geometries : composition [1..*] of ZC_KEMERA_COMPDEC_GEOMS;


}
