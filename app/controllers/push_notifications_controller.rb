class PushNotificationsController < ApplicationController
  def create
    Rails.logger.info "Sending push notification from #{push_params.inspect}"
    subscription_params = fetch_subscription_params

    WebpushJob.perform_now fetch_message,"",push_params.fetch(:icon,"/images/unal/escudoUnal_black.png"),
      endpoint: subscription_params[:endpoint],
      p256dh: subscription_params.dig(:keys, :p256dh),
      auth: subscription_params.dig(:keys, :auth)

    head :ok
  end

  private

  def push_params
    params.permit(:message,:body,:icon, { subscription: [:endpoint, keys: [:auth, :p256dh]]})
  end

  def fetch_message
    push_params.fetch(:message, "Bienvenido al Sistema de Información de Tesis de Grupos de Investigación")
  end

  def fetch_subscription_params
    @subscription_params ||= push_params.fetch(:subscription) { extract_session_subscription }
  end

  def extract_session_subscription
    subscription = session.fetch(:subscription) { raise PushNotificationError,
                                                          "Cannot create notification: no :subscription in params or session" }

    JSON.parse(subscription).with_indifferent_access
  end
end
