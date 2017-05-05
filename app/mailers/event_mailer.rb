class EventMailer < ApplicationMailer
default from: 'sigit_Events@unal.edu.co'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.emailCreated.subject
  #
  def emailCreated(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "New Event was created")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.joinEmail.subject
  #
  def joinEmail(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "New Joins to Your Event")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.updateEmail.subject
  #
  def updateEmail(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Event has changed")
  end
end
