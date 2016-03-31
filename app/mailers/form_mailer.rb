class Form_mailer < ActionMailer::Base

  default :from => "help@example.org"
  default :to => "questions@example.org"

  def new_appointment(form_appointment)
    @form_appointment =form_appointment
    mail(:subject => 'help request')
  end

  def new_request(form_request)
    @form_request = form_request
    mail(:subject => 'general request')
  end

end
