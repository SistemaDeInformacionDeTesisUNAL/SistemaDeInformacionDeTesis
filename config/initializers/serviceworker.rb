Rails.application.configure do
  config.serviceworker.routes.draw do
    match "firebase-messaging-sw.js"
    match "manifest.json"
  end
end
