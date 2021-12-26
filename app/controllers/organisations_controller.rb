class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[show edit update destroy]
  # allows only logged in users
  before_action :require_user_logged_in!

  def index
    @organisations = Organisation.all
  end

  def show; end

  def edit; end

  def update
    if @organisation.update(organisation_params)
      redirect_to @organisation
    else
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      redirect_to @organisation
    else
      render :new
    end
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:id])
    authorize @organisation
  end

  def organisation_params
    params.required(:organisation).permit(:name, :logo)
  end
end
