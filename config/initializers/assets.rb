# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( old/home.css )
Rails.application.config.assets.precompile += %w( old/about.css )
Rails.application.config.assets.precompile += %w( old/w3.css )
Rails.application.config.assets.precompile += %w( old/font-awesome.css )
Rails.application.config.assets.precompile += %w( old/font-lato.css )

Rails.application.config.assets.precompile += %w( css/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( css/bootstrap-theme.min.css )
Rails.application.config.assets.precompile += %w( css/reset.css )
Rails.application.config.assets.precompile += %w( css/unal.css )

Rails.application.config.assets.precompile += %w( css/session.css )
Rails.application.config.assets.precompile += %w( css/profile.css )
Rails.application.config.assets.precompile += %w( css/member.css )
Rails.application.config.assets.precompile += %w( css/group_table.css )
Rails.application.config.assets.precompile += %w( css/form.css )
Rails.application.config.assets.precompile += %w( css/jquery-ui.css )
Rails.application.config.assets.precompile += %w( css/jquery-ui.structure.css )
Rails.application.config.assets.precompile += %w( css/jquery-ui.theme.css )
Rails.application.config.assets.precompile += %w( css/fullcalendar.min.css )
Rails.application.config.assets.precompile += %w( css/dataTables.jqueryui.min.css )
Rails.application.config.assets.precompile += %w( css/bootstrap-datetimepicker.css )

#Rails.application.config.assets.precompile += %w( css/base.css )
#Rails.application.config.assets.precompile += %w( css/tablet.css )
#Rails.application.config.assets.precompile += %w( css/phone.css )
#Rails.application.config.assets.precompile += %w( css/small.css )
#Rails.application.config.assets.precompile += %w( css/printer.css )

Rails.application.config.assets.precompile += %w( js/jquery.min.js )
Rails.application.config.assets.precompile += %w( js/jquery-ui.min.js )
Rails.application.config.assets.precompile += %w( js/jquery.dataTables.min.js )
Rails.application.config.assets.precompile += %w( js/dataTables.jqueryui.min.js )
Rails.application.config.assets.precompile += %w( js/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( js/moment.js )
Rails.application.config.assets.precompile += %w( js/fullcalendar.js )
Rails.application.config.assets.precompile += %w( js/bootstrap-select.min.js )
Rails.application.config.assets.precompile += %w( js/bootstrap-datetimepicker.min.js )
Rails.application.config.assets.precompile += %w( js/firebase.js )
Rails.application.config.assets.precompile += %w( js/loader.js )
Rails.application.config.assets.precompile += %w( js/unal.js )
Rails.application.config.assets.precompile += %w( firebase-messaging-sw.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
