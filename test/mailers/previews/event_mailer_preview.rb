# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/emailCreated
  def emailCreated
    EventMailer.emailCreated
  end

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/joinEmail
  def joinEmail
    EventMailer.joinEmail
  end

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/updateEmail
  def updateEmail
    EventMailer.updateEmail
  end

end
