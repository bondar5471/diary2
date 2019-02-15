class Api::V1::DaysController < ActionController::API
  before_action :authenticate_user!

  respond_to :json
  before_action :find_day, only: [:edit, :update, :show]
  def index 
    @days = Day.all.order(:id)
    render json: @days
  end
  
  def show
    render json: @day
  end

  def create;end 

  def edit;end

  def update
    if @day.update(day_params)
      render json: @day
    else
      render json: @day.errors , status: :unprocessable_entity 
    end  
  end

  def destroy;end

  private

  def find_day
    if current_user
      @day = Day.find(params[:id])
    end
  end

  def day_params
    params.require(:day).permit(:date, :successful, :report, :attach_file)
  end
end  