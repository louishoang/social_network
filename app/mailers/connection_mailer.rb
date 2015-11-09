class ConnectionMailer < ApplicationMailer
  def send_notification(recepient_email)
    subject = "Friend Request"

    mail(:from => "louishoang8899@gmail.com",
         :to => recepient_email, :subject => subject) do |format|
      format.text { render "friend_request.text.erb" }
    end
  end
end
