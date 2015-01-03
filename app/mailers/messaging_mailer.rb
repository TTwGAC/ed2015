# encoding: utf-8

class MessagingMailer < ActionMailer::Base
  default from: "burdell@gac2015.com"

  def burdell_broadcast(to, message)
    @message = message
    mail to: to, subject: "[GAC2015] G. Burdell has sent you a message"
  end
end
