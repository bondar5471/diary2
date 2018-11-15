# frozen_string_literal: true

class NoticesController < ApplicationController
  respond_to :json
  before_action :find_notice, only: [:destroy]

  def create
    @notice = Notice.create(notice_params)
    if @notice.persisted?
      render json: @notice, status: 200
    else
      render json: @notice, status: 422
    end
  end

  def destroy
    @notice.destroy
    respond_to do |format|
      format.html { redirect_to days_path }
      format.json { head :text, :title }
    end
  end

  private

  def find_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:text, :title)
  end
end
