class ProfilesController < ApplicationController
  
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
      :current_company
      )
  end

end