# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog

  CatalogController.solr_search_params_logic += [:fq_filter]

  def fq_filter (solr_parameters, user_parameters)
  end

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
        #:qt => 'search',
        :fl => '*',
        :rows => 12
    }

    config.per_page = [12, 24, 48, 100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
    config.index.show_link = 'manifest_label_t' #'headline_t'
    config.index.record_display_type = 'format'

    # solr field configuration for document/show views
    config.show.html_title = 'manifest_label_t'
    config.show.heading = 'manifest_label_t'
    config.show.display_type = 'format'

    config.facet_display = {
        :hierarchy => {
            'project' => ['facet'],
            'decoration' => ['facet'],
            'language' => ['facet'],
            'canvas_label' => ['facet'],
            'content' => ['facet'],
            'structure' => ['facet'],
            'provenance' => ['facet'],
            'manifest_label' => ['facet'],
            'manuscript' => ['facet'],
            #'text_features' => ['facet'],
            'canvas_label' => ['facet']
        }
    }


    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    #config.add_facet_field 'format', :label => 'Format'
    #config.add_facet_field 'pub_date', :label => 'Publication Year', :single => true
    #config.add_facet_field 'subject_topic_facet', :label => 'Topic', :limit => 20
    #config.add_facet_field 'language_facet', :label => 'Language', :limit => true
    #config.add_facet_field 'lc_1letter_facet', :label => 'Call Number'
    #config.add_facet_field 'subject_geo_facet', :label => 'Region'
    #config.add_facet_field 'subject_era_facet', :label => 'Era'

    ##config.add_facet_field 'keyword_facet', :label => 'Keyword'
    #config.add_facet_field 'project_facet', :label => 'Project', :limit => 20

    config.add_facet_field 'project_facet', :label => 'Project',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 1000
    config.add_facet_field 'manifest_label_facet', :label => 'Manuscript Number', :limit => 20
    config.add_facet_field 'manuscript_facet', :label => 'Manuscript',
                            :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 20
    config.add_facet_field 'text_facet', :label => 'Text', :limit => 20
    #config.add_facet_field 'text_features_facet', :label => 'Text',
    #                       :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 20
    config.add_facet_field 'codicological_color_facet', :label => 'Color', :limit => 20
    config.add_facet_field 'letter_form_facet', :label => 'Letter', :limit => 20
    config.add_facet_field 'other_facet', :label => 'Other', :limit => 20
    #config.add_facet_field 'decoration_facet', :label => 'Decoration', :limit => 20


    config.add_facet_field 'decoration_facet', :label => 'Decoration',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 200
    config.add_facet_field 'language_facet', :label => 'Language',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 200
    config.add_facet_field 'content_facet', :label => 'Content',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 200
    config.add_facet_field 'structure_facet', :label => 'Structure',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 200
    config.add_facet_field 'provenance_facet', :label => 'Provenance',
                           :partial => 'blacklight/hierarchy/facet_hierarchy', :limit => 200
    config.add_facet_field 'creator_facet', :label => 'Annotator', :limit => 20
    config.add_facet_field 'canvas_label_facet', :label => 'Folio', :limit => 20
    #config.add_facet_field 'folio_facet', :label => 'Folio', :limit => 20, sort: 'index'
    config.add_facet_field 'motivation_facet', :label => 'Motivation', :limit => 20
    config.add_facet_field 'origin_facet', :label => 'Origin', :limit => 20


    #config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['format', 'language_facet']
    #
    #config.add_facet_field 'example_query_facet_field', :label => 'Publish Date', :query => {
    #   :years_5 => { :label => 'within 5 Years', :fq => "pub_date:[#{Time.now.year - 5 } TO *]" },
    #   :years_10 => { :label => 'within 10 Years', :fq => "pub_date:[#{Time.now.year - 10 } TO *]" },
    #   :years_25 => { :label => 'within 25 Years', :fq => "pub_date:[#{Time.now.year - 25 } TO *]" }
    #}


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'canvas_label_t', :label => 'Folio:'
    config.add_index_field 'tags_t', :label => 'Tags:'
    config.add_index_field 'created_by_t', :label => 'Created By:'


    # !!!!! NOT USED, see sidebar.rb
    # solr fields to be displayed in the show (single result) view
    # The ordering of the field names is the order of the display
    config.add_show_field 'manifest_label_t', :label => 'Manuscript'
    config.add_show_field 'canvas_label_t', :label => 'Folio:'
    config.add_show_field 'creator_t', :label => 'Tagged by:'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 



    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 



    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, date_created_dt desc, title_sort asc', :label => 'relevance'
    #config.add_sort_field 'date_created_dt desc, title_sort asc', :label => 'year'
    config.add_sort_field 'manifest_label_s asc', :label => 'manuscript'
    config.add_sort_field 'manifest_label_s asc, canvas_label_s asc', :label => 'manuscript and folio'
    config.add_sort_field 'folio_s asc', :label => 'folio'


    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 1
  end

  # Email Action (this will render the appropriate view on GET requests and process the form and send the email on POST requests)
  def email
    @response, @documents = get_solr_response_for_field_values(SolrDocument.unique_key,params[:id])
    if request.post?
      if params[:to]
        url_gen_params = {:host => request.host_with_port, :protocol => request.protocol}

        flash[:error] = I18n.t('blacklight.email.user_not_signed_in') if !user_signed_in?

        if params[:to].match(/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
          email = RecordMailer.email_record(@documents, {:to => params[:to], :message => params[:message]}, url_gen_params)
        else
          flash[:error] = I18n.t('blacklight.email.errors.to.invalid', :to => params[:to])
        end
      else
        flash[:error] = I18n.t('blacklight.email.errors.to.blank')
      end

      unless flash[:error]
        email.deliver
        flash[:success] = "Email sent"
        redirect_to catalog_path(params['id']) unless request.xhr?
      end
    end

    unless !request.xhr? && flash[:success]
      respond_to do |format|
        format.js { render :layout => false }
        format.html
      end
    end
  end

  # Prohibit SMS
  def sms
    flash[:error] = "SMS not enabled"
  end

  def monitor
    data = find(nil)
    count = User.count
    @monitor_ok = true
    render :layout => false
  end

end 