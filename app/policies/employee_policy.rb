class EmployeePolicy < ApplicationPolicy
  def show?
    return false if user.nil?

    case user.role
    when Employee.roles[:employee]
      user.id == record.id
    when Employee.roles[:admin]
      user.organisation.id == record.organisation.id
    when Employee.roles[:system]
      true
    else
      false
    end
  end

  def update?
    return false if user.nil?

    case user.role
    when Employee.roles[:employee]
      user.id == record.id
    when Employee.roles[:admin]
      user.organisation.id == record.organisation.id
    when Employee.roles[:system]
      true
    else
      false
    end
  end

  def create?
    return false if user.nil?

    case user.role
    when Employee.roles[:employee]
      false
    when Employee.roles[:admin]
      user.organisation.id == record.organisation.id
    else
      true
    end
  end

  def destroy?
    return false if user.nil?

    case user.role
    when Employee.roles[:system]
      true
    when Employee.roles[:admin]
      user.organisation.id == record.organisation.id
    else
      false
    end
  end
end
