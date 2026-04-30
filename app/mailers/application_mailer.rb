class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch("RESEND_FROM", "noreply@kai-architect.com") }
  layout "mailer"
end
