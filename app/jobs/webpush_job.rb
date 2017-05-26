class WebpushJob < ActiveJob::Base
  queue_as :default

  def perform(message,body, icon,params)
    client = WebpushClient.new

    log("sending #{message} to #{params[:endpoint]}")
    response = client.send_notification(message,body,icon, params)
    log(response ? "success" : "failed")
    log(response.body.inspect)
  end

  def log(message)
    Rails.logger.info("[WebpushClient] #{message}")
  end
end
