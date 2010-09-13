class SidesController < ApplicationController
  respond_to :html

  def index
    respond_with(@sides = Side.all)
  end

  def show
    respond_with(@side = Side.find(params[:id]))
  end

  def edit
    @side = Side.find(params[:id])
    respond_with(@side)
  end

  def update
    @side = Side.find(params[:id])
    @side.update_attributes(params[:side])
    respond_with(@side)
  end
end