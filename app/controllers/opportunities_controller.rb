class OpportunitiesController < ApplicationController
  def new
    @opportunity = nonprofit.opportunities.new
  end

  def create
    @opportunity = nonprofit.opportunities.build(opportunity_params)

    if @opportunity.save
      flash[:notice] = 'Your opportunity has been created successfully.'
      redirect_to nonprofit_opportunity_path(nonprofit, @opportunity)
    else
      render :new
    end
  end

  def show
    @opportunity = nonprofit.opportunities.find(params[:id])
  end

  protected

  def nonprofit
    Nonprofit.find(params[:nonprofit_id])
  end

  def opportunity_params
    params.require(:opportunity).permit(
      :description,
      :current_stack,
      :street_address,
      :city,
      :state,
      :extra_details,
      :duration,
      :time_commitment,
      :start_date,
      :end_date,
      :headline,
      :zipcode,
      :nonprofit_id,
      :application_info,
      skill_ids: [] 
      )
  end
end