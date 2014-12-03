class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:index, :show, :edit, :update, :destroy]

  # GET /categories

  ##set the sessions election_year_id
  def index
       @election_year = ElectionYear.find(params[:election_year_id])
       @county = @user[:county]
       @salary_categories, @salary_total =  Category.get_completed_or_started(params[:election_year_id], @county, "salaries")
       @supply_categories, @supply_total  =  Category.get_completed_or_started(params[:election_year_id], @county, "services & supplies")
       @year_total = @salary_total + @supply_total
       #set the election_year session
       session[:election_year] = @election_year.id
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end


  # GET /categories/1/edit
  def edit
  end


  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      puts params
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :started, :complete)
    end
end
