class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(id)
    connection = Connection.find(id)
    recepient = connection.friend
    ConnectionMailer.send_notification(recepient.email).deliver_now
  end
end