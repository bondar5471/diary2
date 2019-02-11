class Api::V1::TasksController < ActionController::API
  respond_to :json

  before_action :find_day
  before_action :find_task, only: %i[show edit update]
  
  def index 
    @tasks = Task.all
    render json: @tasks
  end
  
  def show
    render json: @task
  end

  def create 
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors , status: :unprocessable_entity
    end    
  end 

  def edit;end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors , status: :unprocessable_entity 
    end  
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    if @task.destroy
      head :no_content, status: :ok
    else
      render json: @task.errors , status: :unprocessable_entity  
    end  
  end

  private

  def find_task
    @day = Task.find(params[:id])
  end

  def find_day
    @day = Day.find(params[:day_id])
  end

  def task_params
    params.require(:task).permit(:list, :date_end, :status, :duration, :importance)
  end
end

