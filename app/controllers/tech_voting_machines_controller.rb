class TechVotingMachinesController < ApplicationController
  before_action :set_tech_voting_machine, only: [:show, :edit, :update, :destroy]

  # GET /tech_voting_machines
  # GET /tech_voting_machines.json
  def index
    @tech_voting_machines = TechVotingMachine.all
  end
#http://stackoverflow.com/questions/4641565/rails-3-submit-a-form-with-multiple-records
  # GET /tech_voting_machines/1
  # GET /tech_voting_machines/1.json
  def show
  end

  # GET /tech_voting_machines/new
  def new
    @tech_voting_machine = TechVotingMachine.new
    puts @tech_voting_machine.inspect
  end

  # GET /tech_voting_machines/1/edit
  def edit
  end

  # POST /tech_voting_machines
  # POST /tech_voting_machines.json
  def create
    @tech_voting_machine = TechVotingMachine.new(tech_voting_machine_params)

    respond_to do |format|
      if @tech_voting_machine.save
        format.html { redirect_to @tech_voting_machine, notice: 'Tech voting machine was successfully created.' }
          else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /tech_voting_machines/1
  # PATCH/PUT /tech_voting_machines/1.json
  def update
    respond_to do |format|
      if @tech_voting_machine.update(tech_voting_machine_params)
        format.html { redirect_to @tech_voting_machine, notice: 'Tech voting machine was successfully updated.' }
       else
        format.html { render action: 'edit' }
         end
    end
  end

  # DELETE /tech_voting_machines/1
  # DELETE /tech_voting_machines/1.json
  def destroy
    @tech_voting_machine.destroy
    respond_to do |format|
      format.html { redirect_to tech_voting_machines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_voting_machine
      @tech_voting_machine = TechVotingMachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_voting_machine_params
      params.require(:tech_voting_machine).permit(:voting_equip_type, :purchase_dt, :equip_make, :purchase_price, :quantity, :offset_funds_type, :offset_amount)
    end
end
