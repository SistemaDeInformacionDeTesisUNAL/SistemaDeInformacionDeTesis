Rails.application.configure do
  config.serviceworker.routes.draw do
    match "/serviceworker.js" => "events/serviceworker.js"

    match "/manifest.json" => "events/manifest.json"
  end
end
