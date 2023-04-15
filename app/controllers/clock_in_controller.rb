class ClockInController < ApplicationController
  layout 'login'

  def clock_in_out
    if params[:id].present?
      @location = Location.find_by(id: params[:id]) || Location.find(1)
    else
      @location = Location.find(1)
    end
  end
end