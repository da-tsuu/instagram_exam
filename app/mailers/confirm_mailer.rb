class ConfirmMailer < ApplicationMailer
  def confirm_mail(feed)
    @feed = feed
    puts 'tttttttttttttttttttttttttttttttttttttttttttttttttt'

    mail to: @feed.user.email, subject: "投稿の確認メール"
  end
end
