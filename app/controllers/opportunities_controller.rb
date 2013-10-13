class OpportunitiesController < ApplicationController
  before_filter :authorized_for_nonprofit, except:[:index, :show]

  def index
    if params[:q].present?
      @opportunities = Opportunity.search(params[:q])
    else  
      @opportunities = Opportunity.all
    end
  end

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
    @opportunity = Opportunity.find(params[:id])
  end

  def edit
    @opportunity = nonprofit.opportunities.find(params[:id])
  end

   def update
    @opportunity = nonprofit.opportunities.find(params[:id])

      if @opportunity.update_attributes(opportunity_params)
        redirect_to nonprofit_opportunity_path(nonprofit, @opportunity)
      else
        render :edit
      end
  end

  def destroy
    @opportunity = nonprofit.opportunities.find(params[:id])

    if @opportunity.destroy
      redirect_to nonprofit_path(nonprofit)
    else
      flash[:alert] = 'This opportunity could not be deleted.'
      redirect_to nonprofit_opportunity_path(nonprofit, @opportunity)
    end
  end

  protected

  def authorized_for_nonprofit
    unless Opportunity.createable_by(current_user, nonprofit)
      flash[:alert] = 'You do not have permission to view this page.'
      redirect_to :back
    end
  end

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