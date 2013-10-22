class ProfilesController < ApplicationController
  helper_method :view_user

  def index
    if params[:q].present?
      @profiles = User.search(params[:q]).page(params[:page]).per(10)
    else  
      @profiles = User.all.page(params[:page]).per(10).order("state ASC")
    end 
  end

  def show
    @profile = User.find(params[:id])
  end

  def edit
    @profile = User.find(params[:id])
  end

  def update
    @profile = User.find(params[:id])
      if @profile.update_attributes(user_params)
        redirect_to profile_path(current_user)
      else
        render :edit
      end
  end

  def view_user
    @view_user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :city,
      :state,
      :zipcode,
      :about_me,
      :current_company,
      :birthday,
      :education,
      :reason_here,
      skill_ids: []
      )
  end

end