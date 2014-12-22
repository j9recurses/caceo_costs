# Be sure to restart your server when you modify this file.

#CaceoCosts::Application.config.session_store :cookie_store, key: '_caceo_costs_session'
CaceoCosts::Application.config.session_store :active_record_store, expire_after: 12.hours
