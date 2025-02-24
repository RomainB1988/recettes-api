# frozen_string_literal: true

Devise.setup do |config|
  # Email du sender Devise
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # Charge le modèle ORM
  require 'devise/orm/active_record'

  # Authentification sans sensibilité à la casse et suppression des espaces
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Désactiver la session pour Devise dans une API
  config.skip_session_storage = [:http_auth, :params_auth]

  # Longueur des mots de passe
  config.password_length = 6..128

  # Validation d'email basique
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Configuration des sessions pour l'API
  config.navigational_formats = []

  # Active le support JWT
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret_key || ENV['DEVISE_JWT_SECRET_KEY']
    jwt.dispatch_requests = [
      ['POST', %r{^/api/v1/users/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/api/v1/users/sign_out$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end

  # Pour éviter les erreurs liées à Hotwire/Turbo avec Devise
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
