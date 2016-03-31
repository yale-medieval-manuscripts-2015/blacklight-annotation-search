module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  ##
  # Render the index field label for a document
  #
  # @overload render_document_show_field_value(options)
  #   Use the default, document-agnostic configuration
  #   @param [Hash] opts
  #   @options opts [String] :field
  #   @options opts [String] :value
  #   @options opts [String] :document
  # @overload render_document_show_field_value(document, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [Hash] opts
  #   @options opts [String] :field
  #   @options opts [String] :value
  # @overload render_document_show_field_value(document, field, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [String] field
  #   @param [Hash] opts
  #   @options opts [String] :value
  def render_document_show_field_value_search_link *args
    options = args.extract_options!
    document = args.shift || options[:document]

    field = args.shift || options[:field]
    value = options[:value]

    search_field = options[:search_field]

    field_config = document_show_fields(document)[field]

    value ||= case
                when value
                  value
                when (field_config and field_config.helper_method)
                  send(field_config.helper_method, options.merge(:document => document, :field => field))
                when (field_config and field_config.highlight)
                  document.highlight_field(field_config.field).map { |x| x.html_safe }
                else
                  document.get(field, :sep => nil) if field
              end

    value = [value] unless value.is_a? Array
    value = value.collect { |x| x.respond_to?(:force_encoding) ? x.force_encoding("UTF-8") : x}
    return value.map { |v|
      display = html_escape v
      display = "<a href=\"/?q=#{v}&search_field=#{search_field}\">#{display.html_safe}</a>"
    }.join(field_value_separator)
  end

  def render_links(labels, links, html_options)
    return if links.nil? or links.empty?
    html = "<dt>Related: </dt>"
    if links.is_a?Array
      links.each_with_index { |link, index|
        label = labels[index] || link
        html += "<dd>" + link_to( "#{label}", "#{link}", html_options) + "</dd>"
      }
    end
    html.html_safe
  end

  def render_link_to_mirador(document)
    html = ""
    return nil unless document[:canvas_label_t] &&
        document[:canvas_label_t][0]
    return document[:canvas_label_t][0] unless  document[:project_id_t] &&
        document[:project_id_t][0] &&
        document[:manifest_s]

    manifest_url = CGI.escape(document[:manifest_s]).gsub("+", "%20")
    project_id = document[:project_id_t][0]
    canvas_label = CGI.escape(document[:canvas_label_t][0]).gsub("+", "%20")
    link_text = document[:canvas_label_t][0]
    targetUri = "http://desmm.ydc2.yale.edu/projects/#{project_id}?canvas_label=#{canvas_label.to_s}&manifest_uri=#{manifest_url}.json"
    html = "<a href=\"#{targetUri}\" target='_blank'>#{link_text}</a>"
    html.html_safe
  end

  def render_thumb(iiif_image, max_width)
    return nil if iiif_image.nil?
    return iiif_image if max_width.nil?
    return iiif_image if iiif_image.index('full/0/native.jpg').nil?
    # Special handling for images from Stanford: use /pct:/ instead of /x,/
    if (iiif_image.index('stacks') and iiif_image.match('/\d*,\d*,(\d*),\d*/'))
      match = iiif_image.match('/\d*,\d*,(\d*),\d*/')
      return iiif_image unless match and match.captures.length > 0
      pct = (max_width / match.captures[0].to_f) * 100
      iiif_image.sub!(/full\/0\/native.jpg/, "pct:#{pct}/0/native.jpg")
    else
      iiif_image.sub!(/full\/0\/native.jpg/, "#{max_width},/0/native.jpg")
    end
  end

  def render_metadata_fields(document)
    return nil unless document['metadata_keys_t'] and document['metadata_values_t'] and (document['metadata_keys_t'].length == document['metadata_values_t'].length)
    html = ""
    document['metadata_keys_t'].each_index { |i|
      key = document['metadata_keys_t'][i]
      value = document['metadata_values_t'][i]
      html += "<dt>#{key}:</dt><dd>#{value}</dd>"
    }
    return html.html_safe
  end

end