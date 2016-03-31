class MailController < ApplicationController

  def new_request
    @form_request = Form_request.new
  end

  def create_request
    @form_request = Form_request.new(params)

   # if @message.valid?
      Form_mailer.new_request(@form_request).deliver!
      redirect_to(:back, :notice => "Message was successfully sent.")
    #else
    #  flash.now.alert = "Please fill all fields."
    #  render :new
    #end
  end

  def new_appointment
    @form_appointment = Form_appointment.new
  end

  def create_appointment
    @form_appointment = Form_appointment.new(params)

    # if @message.valid?
    Form_mailer.new_appointment(@form_appointment).deliver!
    redirect_to(:back, :notice => "Message was successfully sent.")
    #else
    #  flash.now.alert = "Please fill all fields."
    #  render :new
    #end
  end

end