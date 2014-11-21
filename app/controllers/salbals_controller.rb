class SalbalsController < ApplicationController
  include Surveyable

before_action :authenticate_user
before_action :get_user, :get_year,  :get_model_name, :get_category
before_action :get_category_description, only: [:show]
before_action :load_object, only: [:show, :update, :edit, :destroy]
before_action :load_wizard, only: [:new, :edit, :create, :update]
before_action :get_filtered, only:[:show]
before_action :print_controller_name

  before_action :memo_model_name,  :make_survey_annotations, :make_survey_pages, :make_survey_name,  except: :destroy

  def memo_model_name
    @model_name ||= get_model_name
  end

  # to not interfere with #get_category_descriptions defined on all controllers
  def make_survey_annotations
    @survey_form_model ||= CategoryDescription.where(model_name: memo_model_name)
  end

  def make_survey_pages
    # questions = @survey_form_model.pluck(:field, :label)
    # @survey_pages = questions.compact.in_groups_of(12)
  end

  # def make_cost_type
    # @cost_type = @survey_form_model.pluck(:cost_type).uniq
  # end

  def make_survey_name
    # @survey_name ||= @survey_form_model.pluck(:name).first.titleize
  end

  ############

  def index
   if @category.started.to_s
        id = Salbal.where(county: @user[:county], election_year_id: @election_year_id).pluck(:id).last
         redirect_to salbal_path(id)
   else
      redirect_to new_salbal_path
    end
  end

  def show
    @survey_data_model = Salbal.find(params[:id])
    render file: "#{ Rails.root.join('app/views/surveys/show') }"
  end

  def new
    render file: "#{ Rails.root.join('app/views/surveys/new') }"
  end

  def edit
    render file: "#{ Rails.root.join('app/views/surveys/edit') }"
  end

  def create
      @year_element = @election_year.year_elements.create(:element => @survey_data_model)
      if @wizard.save && @year_element.save
        Salbal.category_status(@category.id, @survey_data_model)
        redirect_to @survey_data_model, notice: "The " + @category.name  +  " Costs That You Entered For " + @election_year[:year] .to_s + " were Successfully Saved."
      else
        render file: "#{ Rails.root.join('app/views/surveys/new') }"
      end
    end


  def update
     if @wizard.save
      Salbal.category_status( @category.id, @survey_data_model)
      redirect_to @survey_data_model, notice: "The " + @category.name  +  " Costs That You Entered For " + @election_year[:year] .to_s + " were Successfully Updated."
    else
      render file: "#{ Rails.root.join('app/views/surveys/edit') }"
    end
  end

  def destroy
    Salbal.remove_category_status(@category.id)
    @salbal.destroy
    redirect_to salbals_path
  end


  private

  def print_controller_name
    puts "&&&&&&@@@@@@ #{}{self.controller_name}"
  end

    def get_model_name
      @model_name = "salbals"
    end

     def get_filtered
      c = FilterCost.where(filtertype: "comment").pluck(:fieldlist)
      @filtercomments =  eval(c[0])
      p = FilterCost.where(filtertype: "percent").pluck(:fieldlist)
      @filterpercents = eval(p[0])
       h = FilterCost.where(filtertype: "hour").pluck(:fieldlist)
      @filterhours = eval(h[0])
    end


  def load_object
    @salbal = Salbal.find(params[:id])
  end

  def load_wizard
    @wizard ||= ModelWizard.new(@salbal || Salbal, session, params)
    if self.action_name.in? %w[new edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
    @survey_data_model = @wizard.object
  end

  def get_category
    @category= Category.find_by(election_year_id: @election_year_id, county: @user[:county],  model_name: @model_name)
  end

  def get_category_description
    @category_description = CategoryDescription.where(model_name: @model_name)
  end


#change params to get working
    # Never trust parameters from the scary internet, only allow the white list through.
    def salbal_params
      params.require(:salbal).permit(
      :salbaldesign, :salbaltrans, :salbalorder, :salbalmail, :salbalother, :salbalpsrp, :salbalpsop, :salbaltsrp, :salbaltsop, :salbaltotbe, :salbaltotbep, :salbalbeps, :salbalbepsp, :salbalbets, :salbalbetsp, :salbaltothrs, :salbalhrsps, :salbalhrsts, :salbalcomment,  :election_year_id, :county, :current_step
      )
    end
end
