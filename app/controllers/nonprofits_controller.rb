class NonprofitsController < ApplicationController
  def new
    @nonprofit = Nonprofit.new
  end

  def create
    @nonprofit = Nonprofit.new
    @nonprofit = current_user.build_nonprofit(nonprofit_params)

    if @nonprofit.save
      flash[:notice] = 'Your Nonprofit has been created successfully.'
      redirect_to nonprofit_path(@nonprofit)
    else
      render :new
    end
  end

  private

  def nonprofit_params
    params.require(:nonprofit).permit(
      :name, 
      :ein_num, 
      :date_founded, 
      :phone_number,
      :fax_number,
      :street_address,
      :street_address_2,
      :state,
      :city,
      :zipcode,
      :email_address,
      :website_string,
      :description_mission,
      :cause
      )
  end

end