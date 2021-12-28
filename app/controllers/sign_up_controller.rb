class SignUpController < ApplicationController
  def index
    @employee = Employee.new
    @organisations = Organisation.all.map { |organisation| [organisation.name, organisation.id] }
  end

  def new
    @employee = Employee.new(sign_up_params)

    if @employee.save
      WelcomeMailer.with(user: @employee).welcome_email.deliver_now
      # deliver_now is provided by ActiveJob.
      redirect_to login_path, notice: 'Successfully created account'
    else
      @organisations = Organisation.all.map { |organisation| [organisation.name, organisation.id] }
      render :index
    end
  end

  def verify_account
    @employee = Employee.find(params[:id])
    @employee.update(verified: true)

    redirect_to login_path
  end

  def about
    render 'sign_up/about'
  end

  private

  def sign_up_params
    params.require(:employee).permit(:fname, :password, :lname, :email, :organisation_id, :role, :birthday,
                                     :avatar)
          .with_defaults(role: Employee.roles[:employee])
  end
end
