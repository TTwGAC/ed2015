# encoding: utf-8

class MessagingMailer < ActionMailer::Base
  default from: "get.a.clue.2015@gmail.com"

  def burdell_broadcast(to, message)
    @message = message
    mail to: to, subject: "[GAC2015] G. Burdell has sent you a message"
  end
end
