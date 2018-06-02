class NotificationMailer < ApplicationMailer
  default from: ENV["DEFAULT_FROM_EMAIL"]
  layout 'mailer'

  def sanity_check_email(stats)
    @stats = stats
    mail(to: ENV["DEFAULT_TO_EMAIL"], subject: 'Marketdata sanity report')
  end
end
