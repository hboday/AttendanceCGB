class CalendarController < ApplicationController
  def show
    @month = params[:month].to_i
    @year = params[:year].to_i
  end
end