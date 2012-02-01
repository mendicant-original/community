if Rails.env.production?
  Community::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[Community] ",
    :sender_address => %{"Community Notifier" <notifier@community.com>},
    :exception_recipients => %w{jordan.byron@gmail.com community@gmail.com}
end
