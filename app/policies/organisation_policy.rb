class OrganisationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.role == Employee.roles[:system] || user.organisation.id == record.id
  end

  def create?
    user.role == Employee.roles[:system]
  end

  def update?
    user.role != Employee.roles[:employee]
  end

  def destroy?
    user.role == Employee.roles[:system]
  end
end
