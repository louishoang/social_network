class BackgroundWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(conn_id)
    connection = Connection.find(conn_id)
    recepient = connection.friend
    ConnectionMailer.send_notification(recepient.email).deliver_now
  end
end