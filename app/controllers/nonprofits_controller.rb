class NonprofitsController < ApplicationController
  
  def index
    if params[:q].present?
      @nonprofits = Nonprofit.search(params[:q]).page(params[:page]).per(10)
    else  
      @nonprofits = Nonprofit.all.page(params[:page]).per(10)
    end 
  end

  def new
    @nonprofit = Nonprofit.new
  end

  def create
    @nonprofit = Nonprofit.new
    @nonprofit = current_user.nonprofits.build(nonprofit_params)

    if @nonprofit.save
      flash[:notice] = 'Your Nonprofit has been created successfully.'
      redirect_to nonprofit_path(@nonprofit)
    else
      render :new
    end
  end

  def show
    @nonprofit = Nonprofit.find(params[:id])
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
  end

  def update
    @nonprofit = Nonprofit.find(params[:id]) 
      if @nonprofit.update_attributes(nonprofit_params)
        redirect_to nonprofit_path(@nonprofit)
      else
        render :edit
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
      :cause,
      :image,
      :mission,
      :vision
      )
  end

end