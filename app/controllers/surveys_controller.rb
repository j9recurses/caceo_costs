class SurveysController < ApplicationController
  before_action :authenticate_user
  before_action :get_user, :get_year, :get_category
  before_action :model_singular
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
    @survey_data = klass.find(params[:id])
    render file: "#{ Rails.root.join('app/views/surveys/show') }"
  end

  def new
    @survey_data = klass.new
    session[session_model_params] = {}
    @survey_data.current_step = 0
    render file: "#{ Rails.root.join('app/views/surveys/new') }"
  end

  def edit
    @survey_data = klass.find(params[:id])
    session[session_model_params] = {}
    @survey_data.current_step = 0
    render file: "#{ Rails.root.join('app/views/surveys/edit') }"
  end

  def create
    session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]
    @survey_data = klass.new(session[session_model_params])
    if @survey_data.valid?
      if params[:back_button]
        @survey_data.step_back
      elsif params[:save_and_exit] || @survey_data.last_step?
        if @survey_data.save && @election_year.year_elements.find_or_create_by(element: @survey_data)
          klass.category_status(@category.id, @survey_data)
          flash[:notice] = "The #{@category.name} Costs That You Entered For #{@election_year[:year]} Were Successfully Saved."
          session[session_model_params] = nil
          redirect_to @survey_data
        end
      elsif params[:save_and_continue]
        if @survey_data.save && @election_year.year_elements.find_or_create_by(element: @survey_data)
          klass.category_status(@category.id, @survey_data)
          flash.now[:notice] = "Your progress has been saved."
          @survey_data.step_forward
        end
      else
        @survey_data.step_forward
      end
    end
    if @survey_data.new_record?
      render file: "#{ Rails.root.join('app/views/surveys/new') }"
    else
      render file: "#{ Rails.root.join('app/views/surveys/edit') }" unless performed?
    end
  end

  def update
    session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]
    @survey_data = klass.new(session[session_model_params])
    if @survey_data.valid?
      if params[:back_button]
        @survey_data.step_back
      elsif params[:save_and_exit] || @survey_data.last_step?
        if @survey_data.save
          klass.category_status(@category.id, @survey_data) if @survey_data.save
          session[session_model_params] = nil
          flash[:notice] = "The #{@category.name} Costs That You Entered For #{@election_year[:year]} Were Successfully Updated."
          redirect_to @survey_data
        end
      elsif params[:save_and_continue]
        klass.category_status(@category.id, @survey_data) if @survey_data.save
        flash.now[:notice] = "Your progress has been saved."
        @survey_data.step_forward
      else
        @survey_data.step_forward
      end
    end
    render file: "#{ Rails.root.join('app/views/surveys/edit') }" unless performed?
  end

  def destroy
    @survey_data = klass.find(params[:id])
    klass.remove_category_status(@category.id)
    @survey_data.destroy
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

  def session_model_params
    @session_model_params ||= "#{model_singular}_params"
  end

  def klass
    @klass ||= model_name.singularize.capitalize.constantize
  end

  def get_category
    @category= Category.find_by(election_year_id: @election_year_id, county: @user[:county],  model_name: model_name)
  end
end
