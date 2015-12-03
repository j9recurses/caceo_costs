class TechVotingMachinesController < ApplicationController
  before_action :set_tech_voting_machine, only: [:show, :edit, :update, :destroy]
  before_action :get_user

  # GET /tech_voting_machines
  # GET /tech_voting_machines.json
  def index
    @county_name  = County.where(id: @user[:county_id]).pluck(:name)
    @tech_voting_machines = TechVotingMachine.where(county_id: @user[:county_id])
  end

  # GET /tech_voting_machines/1
  # GET /tech_voting_machines/1.json
  def show
    @tech_voting_machine = TechVotingMachine.find(params[:id])
  end

  # GET /tech_voting_machines/new
  def new
    @tech_voting_machine = TechVotingMachine.new
  end

  # GET /tech_voting_machines/1/edit
  def edit
    @tech_voting_machine = TechVotingMachine.find(params[:id])
  end

  # POST /tech_voting_machines
  # POST /tech_voting_machines.json
  def create
    @tech_voting_machines = TechVotingMachine.where(county_id: @user[:county_id])
    @tech_voting_machine = TechVotingMachine.create(tech_voting_machine_params)
  end

  # PATCH/PUT /tech_voting_machines/1
  # PATCH/PUT /tech_voting_machines/1.json
  def update
      @tech_voting_machines = TechVotingMachine.where(county_id: @user[:county_id])
      @tech_voting_machine.update(tech_voting_machine_params)
  end

 def delete
    @tech_voting_machine =  TechVotingMachine.find(params[:tech_voting_machine_id])
  end

  def destroy
    @tech_voting_machines = TechVotingMachine.where(county_id: @user[:county_id])
    @tech_voting_machine = TechVotingMachine.find(params[:id])
   @tech_voting_machine.destroy
  end

private
  # for some reason delete has its id in params[tech_voting_machine_id]
  def current_resource
    @current_resource ||= if params[:id]
      TechVotingMachine.find(params[:id])
    elsif params[:tech_voting_machine_id]
      TechVotingMachine.find(params[:tech_voting_machine_id])
    else
      params['tech_voting_machine']
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_tech_voting_machine
    @tech_voting_machine = TechVotingMachine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tech_voting_machine_params
    params.require(:tech_voting_machine).permit(:county_id, :purchase_price_services, :voting_equip_type, :purchase_dt, :equip_make, :purchase_price, :quantity, :offset_funds_src, :offset_amount)
  end
end
