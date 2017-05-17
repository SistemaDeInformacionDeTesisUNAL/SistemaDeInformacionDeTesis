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
  #Recordatorio
  def rememberEmail(**args)
    @event= args[:event]
    @user = args[:user]
    @url  = 'http://localhost:3000/events/'+@event.id.to_s+'.html'
    mail(to: @user.email, subject: "Event: "+@event.name)
  end
  #Unirse a grupo de investigacion
  def joinInvestigationEmail(**args)
    @hSolicitud = DateTime.now
    @group= args[:group]
    @user = args[:user]
    @Owner= args[:owner]
    @url  = 'http://localhost:3000/investigation_groups/'+@group.id.to_s+'.html'
    mail(to: @Owner.email, subject: "Nueva solicitud para ingresar al grupo: "+@group.name)
  end

#Cambio de estado de grupo de investigacion
  def stateChangedInvestigationEmail(**args)
    @hSolicitud = DateTime.now
    @group= args[:group]
    @user = args[:user]
    @state= args[:state]
    @url  = 'http://localhost:3000/investigation_groups/'+@group.id.to_s+'.html'
    mail(to: @user.email, subject: "Tu estado en el grupo "+@group.name+" ha cambiado")
  end
#Creacion de contribucion
  def contributionCreated(**args)
    @group= args[:group]
    @user = args[:user]
    @Owner= args[:owner]
    @contribution = args[:contribution]
    @url  = 'http://localhost:3000/contributions/'+@contribution.id.to_s+'.html'
    mail(to: @Owner.email, subject: "Nueva contribucion en el grupo "+@group.name)
  end

  #Cambio de rol de un profesor
    def rolChanged(**args)
      @hSolicitud = DateTime.now
      @group= args[:group]
      @user = args[:user]
      @rol= args[:rol]
      @url  = 'http://localhost:3000/investigation_groups/'+@group.id.to_s+'.html'
      mail(to: @user.email, subject: "Tu rol en el grupo "+@group.name+" ha cambiado")
    end

    #Cambio de (estado de una contribucion
    def stateContributionChanged(**args)
      @hSolicitud = DateTime.now
      @group= args[:group]
      @user = args[:user]
      @state= args[:state]
      @contribution= args[:contribution]    
      @url  = 'http://localhost:3000/contributions/'+@contribution.id.to_s+'.html'
      mail(to: @user.email, subject: "Nuevo estado de la contribucion "+@contribution.name)
    end

end
