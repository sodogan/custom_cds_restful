CLASS zcl_kemeracompdec_geoms_hand DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: tt_kemera_compdec_geoms TYPE STANDARD TABLE OF zc_kemera_compdec_geoms WITH DEFAULT KEY.
    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_kemeracompdec_geoms_hand IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
**Here We need to do query on the CDS View to get the data
    DATA:lt_kemera_compdec_geoms TYPE tt_kemera_compdec_geoms.
    DATA(lv_entity_id) =  io_request->get_entity_id( ).


    CASE lv_entity_id.
      WHEN 'ZC_KEMERA_COMPDEC_GEOMS'.
        IF io_request->is_data_requested( ).

          TRY.
              DATA(lt_req_elements) = io_request->get_requested_elements( ).
              DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements sep = `, ` ).

**parameters
              DATA(lt_parameters) = io_request->get_parameters( ).

*Filter
              DATA(lo_filter) = io_request->get_filter( ).


              DATA(lv_sql_string) = lo_filter->get_as_sql_string( ).
*       where clause
              DATA(lv_where_clause_string) = cl_abap_dyn_prg=>escape_quotes_str( lv_sql_string ).



              DATA(lt_filter) = lo_filter->get_as_ranges( ).

** if filter is empty raise a business exception

              DATA(lv_standreference) = VALUE #( lt_filter[ name = to_upper( 'standreference' ) ]-range[ 1 ]-low OPTIONAL ).
              DATA(lv_financingactnumber) = VALUE #( lt_filter[ name = to_upper( 'financingactnumber' ) ]-range[ 1 ]-low OPTIONAL ).

**raise exception if financingactnumber and standreference not specified
              IF lv_financingactnumber IS INITIAL AND lv_standreference is INITIAL.

                MESSAGE e001(ukm_commons_msg) INTO cl_ukm_commons_auxiliary=>sv_message.

                DATA(lv_) = cx_ukm_commons=>convert_message_to_bapiret( ).

* Raise exception
                RAISE EXCEPTION NEW lcx_business_exception( textid = VALUE #( LET ls_message = cx_ukm_commons=>convert_message_to_bapiret( ) IN
                                                                             msgid = ls_message-id
                                                                             msgno = ls_message-number
                                                                             attr1 = ls_message-message_v1
                                                                             attr2 = ls_message-message_v2
                                                                             attr3 = ls_message-message_v3
                                                                             attr4 = ls_message-message_v4 ) ).

              ENDIF.

**sort elements
              DATA(lt_sort_elements) = io_request->get_sort_elements( ).

** Get the search expression
              DATA(lv_search_expression) = io_request->get_search_expression( ).

*Added for search only
*              IF  NOT lv_search_expression IS INITIAL.
*                DATA(lv_search_filter) =  | GPSQUALITY = { lv_search_expression } | .
*                lv_sql_filter = |({ lv_sql_filter } AND  { lv_search_filter }  )| .
*              ENDIF.

**Set the paging
              DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).

              DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
              DATA(lv_max_rows) = COND #(  WHEN lv_page_size EQ if_rap_query_paging=>page_size_unlimited THEN 1
                                           ELSE lv_page_size
                                         ).


*Query the cds table built on top of table function!
* Notice the p_where parameter passing the where clause- lv_sql_filter
              zcl_gis_amdp_id1174odata=>get_kemeracompdec_geoms(
                EXPORTING
                  iv_where                = lv_where_clause_string
                  iv_offset               = lv_offset
                  iv_max_rows             = lv_max_rows
               IMPORTING
                  out_kemeracompdec_geoms = lt_kemera_compdec_geoms
              ).


*              SELECT (lv_req_elements)
*              FROM zget_kemeracompdec_geoms_tf( p_where = @lv_where_clause_string )
*              ORDER BY ('standreference')
*               INTO CORRESPONDING FIELDS OF TABLE @lt_kemera_compdec_geoms
*              OFFSET @lv_offset UP TO  @lv_max_rows ROWS.

***fill response
              io_response->set_data( it_data = lt_kemera_compdec_geoms ).

***Set the number of records requested!
              IF io_request->is_total_numb_of_rec_requested( ).
                DATA:lv_number_of_records type int8.
                 lv_number_of_records = lines( lt_kemera_compdec_geoms ).

**fill response
                io_response->set_total_number_of_records( lv_number_of_records ).
              ENDIF.


            CATCH cx_rap_query_request_changed cx_rap_query_response_changed cx_rap_query_filter_no_range cx_amdp_error  INTO DATA(lo_x_rap_query).
* Forward exception
              RAISE EXCEPTION NEW lcx_business_exception( textid   = VALUE #( LET ls_message = cx_ukm_commons=>convert_exception_to_bapiret( lo_x_rap_query ) IN
                                                                             msgid = ls_message-id
                                                                             msgno = ls_message-number
                                                                             attr1 = ls_message-message_v1
                                                                             attr2 = ls_message-message_v2
                                                                             attr3 = ls_message-message_v3
                                                                             attr4 = ls_message-message_v4 )
                                                          previous = lo_x_rap_query ).
             CATCH cx_root INTO DATA(lo_exception).
             DATA(lv_errot_text) = lo_exception->get_text( ).

          ENDTRY.


        ENDIF.



      WHEN OTHERS.

    ENDCASE.




  ENDMETHOD.



ENDCLASS.