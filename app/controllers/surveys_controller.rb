class SurveysController < ApplicationController
  before_action :authenticate_user
  before_action :get_user, :get_year, :get_category
  before_action :model_singular
  before_action :object, only: [:show, :update, :edit, :destroy]
  before_action :load_wizard, only: [:new, :edit, :create, :update]
  before_action :make_survey_form_model,  except: :destroy


  def index
    if @category.started == true
      id = klass.where(county: @user[:county], election_year_id: @election_year_id).pluck(:id).last
      redirect_to send("#{model_singular}_path", id)
    else
      redirect_to send("new_#{model_singular}_path")
    end
  end

  def show
    @survey_data_model = object
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
      klass.category_status(@category.id, @survey_data_model)
      redirect_to @survey_data_model, notice: "The #{@category.name} Costs That You Entered For #{@election_year[:year]} were Successfully Saved."
    else
      render file: "#{ Rails.root.join('app/views/surveys/new') }"
    end
  end


  def update
    if @wizard.save
      klass.category_status( @category.id, @survey_data_model)
      redirect_to @survey_data_model, notice: "The #{@category.name} Costs That You Entered For #{@election_year[:year]} were Successfully Updated."
    else
      render file: "#{ Rails.root.join('app/views/surveys/edit') }"
    end
  end

  def destroy
    klass.remove_category_status(@category.id)
    object.destroy
    redirect_to send("#{model_name}_path")
  end

private

  def make_survey_form_model
    @survey_form_model ||= CategoryDescription.where(model_name: model_name)
  end

  def model_name
    @model_name ||= self.class.to_s.gsub('Controller', '').downcase
  end

  def model_singular
    @model_singular ||= model_name.singularize
  end

  def klass
    @klass ||= model_name.singularize.capitalize.constantize
  end

  def object
    @object ||= klass.find(params[:id])
  end

  def load_wizard
    @wizard ||= ModelWizard.new( @object || klass, session, params)
    if self.action_name.in? %w[new edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
    @survey_data_model = @wizard.object
  end

  def get_category
    @category= Category.find_by(election_year_id: @election_year_id, county: @user[:county],  model_name: model_name)
  end
end