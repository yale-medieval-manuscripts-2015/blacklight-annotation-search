
module ApplicationHelper


  def schema_org_json_ld(document)
    return if document.nil?

    title = document[:headline_t]
    description = document[:description_t]
    keywords = document[:keyword_t]
    thumbnail = document[:thumbnail_t]
    dateCreated = document[:date_created_s]
    sublocation = document[:sublocation_t]
    city = document[:city_t]
    country = document[:country_t]
    location = Array.new
    location << sublocation unless sublocation.nil?
    location << city unless city.nil?
    location << country unless country.nil?

    meta = Hash.new
    meta["@context"] = "http://schema.org"
    meta["@type"] = "http://schema.org/ImageObject"
    meta["representativeOfPage"] = true
    meta["name"] = title.join(", ") unless title.nil?
    meta["headline"] = title.join(", ") unless title.nil?
    meta["description"] = description.join(", ") unless description.nil?
    meta["keywords"] = keywords.join(", ") unless keywords.nil?
    meta["dateCreated"] = dateCreated unless dateCreated.nil?

    # creator :
    creators = document[:creator_t]
    unless creators.nil?
      creators.each { |name|
        creator = Hash.new
        if (name.include?("Yale"))
          creator["@type"] = "http://schema.org/Organization"
        else
          creator["@type"] = "http://schema.org/Person"
        end
        creator["name"] = name
        meta["creator"] ||= Array.new
        meta["creator"].push creator
      }

      # about: The subject matter of the content.
      people = document[:person_t]
      unless people.nil?
        people.each {  |name|
          person = Hash.new
          person["@type"] = "http://schema.org/Person"
          person["name"] = name
          meta["about"] ||= Array.new
          meta["about"].push person
        }
      end

      # provider:  Specifies the Person or Organization that distributed the CreativeWork.
      provider = Hash.new
      provider["@type"] = "http://schema.org/Organization"
      provider["name"] = ""
      meta["provider"] = provider

      # thumbnail and url
      unless thumbnail.nil? || thumbnail.length < 1
        thumbnail_url = thumbnail[0]
        meta["thumbnailUrl"] = thumbnail_url
        if thumbnail_url.include?("format/1")
          meta["image"] = thumbnail_url.gsub(/format\/1/, "format/3")
        end
      end

      # location
      unless location.empty?
        meta["contentLocation"] = [ "@type" => "http://schema.org/Place", "name" => location.join(", ") ]
      end

    end
    meta.to_json
  end
end
