if Rails.env.production?
  Community::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[Community] ",
    :sender_address => %{"Mendicant DangerZone" <dangerzone@mendicantuniversity.org>},
    :exception_recipients => %w{jordan.byron@gmail.com}
end
