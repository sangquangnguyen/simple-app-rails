class OrganisationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && (user.role == Employee.roles[:system] || user.organisation.id == record.id)
  end

  def create?
    user.present? && (user.role == Employee.roles[:system])
  end

  def update?
    user.present? && (user.role != Employee.roles[:employee])
  end

  def destroy?
    user.present? && (user.role == Employee.roles[:system])
  end
end
