class WelcomeMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = "http://localhost:3000/verify_account/#{@user.id}"
    mail(to: @user.email, subject: 'Welcome to my awesome tutorial')
  end
end
