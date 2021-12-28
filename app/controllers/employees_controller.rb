class EmployeesController < ApplicationController
  # allows only logged in users
  before_action :require_user_logged_in!
  before_action :set_employee, only: %i[show edit update destroy]

  def show; end

  def edit
    @roles = Employee.roles.map { |key, value| [key, value] }
  end

  def update
    if @employee.update(update_employee_params)
      redirect_to [@employee.organisation, @employee]
    else
      @roles = Employee.roles.map { |key, value| [key, value] }
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to @employee.organisation
  end

  def new
    @organisation = Organisation.find(params[:organisation_id])
    @employee = @organisation.employees.build
    @roles = Employee.roles.map { |key, value| [key, value] }
  end

  def create
    @organisation = Organisation.find(params[:organisation_id])
    @employee = @organisation.employees.create(create_employee_params)

    if @employee.save
      redirect_to [@employee.organisation, @employee]
    else
      @organisation = Organisation.find(params[:organisation_id])
      @roles = Employee.roles.map { |key, value| [key, value] }
      render :new
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
    authorize @employee
  end

  def update_employee_params
    params.required(:employee).permit(:fname, :lname, :avatar, :birthday, :email, :password, :role)
          .with_defaults(verified: true)
  end

  def create_employee_params
    params.required(:employee).permit(:fname, :lname, :avatar, :birthday, :email, :password, :role)
          .with_defaults(verified: true, role: Employee.roles[:employee], password: '123456')
  end
end
