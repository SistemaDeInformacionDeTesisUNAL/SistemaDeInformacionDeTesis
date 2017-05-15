class WebpushClient


  # Send webpush message using subscription parameters
  #
  # @param message [String] text to encrypt
  # @param subscription_params [Hash<Symbol, String>]
  # @option subscription_params [String] :endpoint url to send encrypted message
  # @option subscription_params [Hash<Symbol, String>] :keys auth keys to send with message for decryption
  # @return true/false
  def send_notification(message, endpoint: "", p256dh: "", auth: "")
    raise ArgumentError, ":endpoint param is required" if endpoint.blank?
    raise ArgumentError, "subscription :keys are missing" if p256dh.blank? || auth.blank?

    Rails.logger.info("Sending WebPush notification...............")
    Rails.logger.info("message: #{message}")
    Rails.logger.info("endpoint: #{endpoint}")
    Rails.logger.info("p256dh: #{p256dh}")
    Rails.logger.info("auth: #{auth}")

    Webpush.payload_send \
      message: message,
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth

  end


end
