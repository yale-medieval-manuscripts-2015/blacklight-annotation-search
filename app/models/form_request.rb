class Form_request

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

attr_accessor :firstName, :lastName, :email, :org, :street1, :street2, :city, :state,:zip,
                :country, :phone, :objId, :callNo, :purpose, :terms,:comments

  #validates :name, :email, :subject, :body, :presence => true
  #validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

  def initialize(attributes = {})
    self.firstName = attributes[:firstName]
    self.lastName = attributes[:lastName]
    self.email = attributes[:email]
    self.org = attributes[:org]
    self.street1 = attributes[:street1]
    self.street2 = attributes[:street2]
    self.city = attributes[:city]
    self.state = attributes[:state]
    self.zip = attributes[:zip]
    self.country = attributes[:country]
    self.objId = attributes[:objId]
    self.callNo = attributes[:callNo]
    if !(attributes[:phone1].nil? || attributes[:phone2].nil? || attributes[:phone3].nil?)
      self.phone = attributes[:phone1] +'-' + attributes[:phone2] + attributes[:phone3]
    end
    self.terms = attributes[:terms]
    self.comments = attributes[:comments]


    self.purpose =''
    if !attributes[:personal].nil?
      self.purpose += attributes[:personal]+','
    end
    if !attributes[:website].nil?
      self.purpose += attributes[:website]+','
    end
    if !attributes[:print].nil?
      self.purpose += attributes[:print]+','
    end
    if !attributes[:video].nil?
      self.purpose += attributes[:video]+','
    end
    if !attributes[:commercial].nil?
      self.purpose += attributes[:commercial]+','
    end
    if !attributes[:scholarly].nil?
      self.purpose += attributes[:scholarly]+','
    end
    if self.purpose.size>2
      self.purpose.gsub( /.{1}$/, '' )
    end
  end

  def persisted?
    false
  end

end