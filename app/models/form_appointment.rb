class Form_appointment

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :firstName, :lastName, :email, :date1, :date2, :phone, :instrument, :purpose, :callNo, :terms,:group

                #validates :name, :email, :subject, :body, :presence => true
                #validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

                def initialize(attributes = {})
                    self.firstName = attributes[:firstName]
                    self.lastName = attributes[:lastName]
                    self.email = attributes[:email]
                    self.instrument = attributes[:instrument]
                    self.purpose = attributes[:purpose]
                    self.callNo = attributes[:callNo]
                    self.terms = attributes[:terms]
                    self.group = attributes[:group]
                    if !(attributes[:mm1].nil? || attributes[:dd1].nil? || attributes[:yy1].nil?)
                      self.date1 = attributes[:mm1] +'/' + attributes[:dd1] +'/' + attributes[:yy1]
                    end
                    if !(attributes[:mm2].nil? || attributes[:dd2].nil? || attributes[:yy2].nil?)
                      self.date2 = attributes[:mm2] +'/' + attributes[:dd2] +'/' + attributes[:yy2]
                    end
                    if !(attributes[:phone1].nil? || attributes[:phone2].nil? || attributes[:phone3].nil?)
                      self.phone = attributes[:phone1] +'-' + attributes[:phone2] + attributes[:phone3]
                    end
                end

               def persisted?
                  false
                end

end