class EventMailer < ApplicationMailer
default from: 'sigit_Events@unal.edu.co'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.emailCreated.subject
  #
  def emailCreated(**args)
    @event= args[:event]
    @user = args[:user]
    @url  = 'http://localhost:3000/events/'+@event.id.to_s+'.html'
    mail(to: @user.email, subject: "New Event was created")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.joinEmail.subject
  #
  def joinEmail(**args)
    @event= args[:event]
    @user = args[:user]
    @url  = 'http://localhost:3000/events/'+@event.id.to_s+'.html'
    mail(to: @user.email, subject: "Event: "+@event.name)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.updateEmail.subject
  #
  def updateEmail(**args)
    @event= args[:event]
    @user = args[:user]
    @url  = 'http://localhost:3000/events/'+@event.id.to_s+'.html'
    mail(to: @user.email, subject: "Event: "+@event.name)
  end
end
