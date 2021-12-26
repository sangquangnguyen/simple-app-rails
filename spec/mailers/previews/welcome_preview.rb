# Preview all emails at http://localhost:3000/rails/mailers/welcome
class WelcomePreview < ActionMailer::Preview
  def welcome_email
    WelcomeMailer.with(user: Employee.last).welcome_email
  end
end
