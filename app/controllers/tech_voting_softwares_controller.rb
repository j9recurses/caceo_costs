class TechVotingSoftwaresController < ApplicationController
  before_action :set_tech_voting_software, only: [:show, :edit, :update, :destroy]
  before_action :get_user

  # GET /tech_voting_machines
  # GET /tech_voting_machines.json
  def index
    @county_name  = CaCountyInfo.where(id: @user[:county]).pluck(:name)
    @tech_voting_softwares = TechVotingSoftware.where(county: @user[:county])
  end

  # GET /tech_voting_machines/1
  # GET /tech_voting_machines/1.json
  def show
    @tech_voting_software = TechVotingSoftware.find(params[:id])
  end

  # GET /tech_voting_machines/new
  def new
    @tech_voting_software = TechVotingSoftware.new
  end

  # GET /tech_voting_machines/1/edit
  def edit
    @tech_voting_software = TechVotingSoftware.find(params[:id])
  end

  # POST /tech_voting_machines
  # POST /tech_voting_machines.json
  def create
    @tech_voting_softwares = TechVotingSoftware.where(county: @user[:county])
    @tech_voting_software = TechVotingSoftware.create(tech_voting_software_params)
  end

  # PATCH/PUT /tech_voting_machines/1
  # PATCH/PUT /tech_voting_machines/1.json
  def update
       @tech_voting_softwares = TechVotingSoftware.where(county: @user[:county])
      @tech_voting_software.update(tech_voting_software_params)
  end

 def delete
    @tech_voting_software =  TechVotingSoftware.find(params[:tech_voting_software_id])
  end

  def destroy
    @tech_voting_softwares = TechVotingSoftware.where(county: @user[:county])
    @tech_voting_software = TechVotingSoftware.find(params[:id])
   @tech_voting_software.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_voting_software
      @tech_voting_software = TechVotingSoftware.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_voting_software_params
      params.require(:tech_voting_software).permit(:county, :software_item, :purchase_dt, :purchase_price_hardware, :purchase_price_software, :quantity, :mat_charges, :labor_costs)
    end
end


