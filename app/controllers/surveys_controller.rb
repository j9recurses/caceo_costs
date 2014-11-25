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
    @survey_data_model = klass.find(params[:id])
    render file: "#{ Rails.root.join('app/views/surveys/show') }"
  end

  def new
    @survey_data_model = klass.new
    session[session_model_name] = {}
    @survey_data_model.current_step = 0
    render file: "#{ Rails.root.join('app/views/surveys/new') }"
  end

  def edit
    @survey_data_model = klass.find(params[:id])
    session[session_model_name] = {}
    @survey_data_model.current_step = 0
    render file: "#{ Rails.root.join('app/views/surveys/edit') }"
  end

  def create
    if @survey_data_model.valid?
      @year_element = @election_year.year_elements.create(element: @survey_data_model)

      if @survey_data_model.save && @year_element.save
        klass.category_status(@category.id, @survey_data_model)

      if @survey_data_model.last_step?
        redirect_to @survey_data_model, notice: "The #{@category.name} Costs That You Entered For #{@election_year[:year]} were Successfully Saved."
      else
        @survey_data_model.step_forward
        render file: "#{ Rails.root.join('app/views/surveys/edit') }"
    else
      render file: "#{ Rails.root.join('app/views/surveys/new') }"
    end
  end


  def update
    session[session_model_name].deep_merge!(params[model_singular]) if params[model_singular]

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

  def session_model_name
    @session_model_name ||= "#{model_singular}_params"
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

class ModelWizard
  attr_reader :object

  def initialize(object_or_class, session, params = nil, param_key = nil)
    @object_or_class, @session, @params = object_or_class, session, params
    @param_key = param_key || ActiveModel::Naming.param_key(object_or_class)
    @session_params = "#{@param_key}_params".to_sym
  end


  # def start
  #   @session[@session_params] = {}
  #   set_object
  #   @object.current_step = 0
  # end

  def process
    @session[@session_params].deep_merge!(@params[@param_key]) if @params[@param_key]
    set_object
    @object.assign_attributes(@session[@session_params]) unless class?
  end

  def save
    if @object.current_step_valid?
      return process_save
    end
    false
  end

private

  # def set_object
  #   @object = class? ? @object_or_class.new(@session[@session_params]): @object_or_class
  # end

  # def class?
  #   @object_or_class.is_a?(Class)
  # end

  def process_save
    if @params[:back_button]
      @object.step_back
    elsif @object.last_step?
      if @object.all_steps_valid?
        success = @object.save
        @session[@session_param] = nil
        return success
      end
    elsif @params[:save_and_exit]
      if @object.some_steps_valid?
        success = @object.save
        @session[@session_param] = nil
        return success
      end
    elsif @params[:save_and_continue]

    else
      @object.step_forward
    end
    false
  end
end