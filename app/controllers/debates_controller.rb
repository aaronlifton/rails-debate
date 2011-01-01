class DebatesController < ApplicationController
  layout 'one_col'
  respond_to :html

  def index
 	@debates = Debate.paginate :page => params[:page], :order => 'created_at DESC'
    respond_with(@debates)
  end

  def show
    @debate = Debate.find(params[:id])
    @argument = Argument.new
    respond_with(@debate) do |format|
        format.html { render :layout => "one_col" }
    end
  end

  def new
    @debate = Debate.new
    2.times { @debate.sides.build }
    respond_with(@debate)
  end

  def edit
    @debate = Debate.find(params[:id])
    if @debate.user == current_user
    	respond_with(@debate)
    else
    	redirect_to debate_path(@debate)
    end
  end

  def create
    @debate = Debate.new(params[:debate])
    flash[:notice] = "Debate successfully created" if @debate.save
    respond_with(@debate)
  end

  def update
    @debate = Debate.find(params[:id])
    @debate.update_attributes(params[:debate])
    respond_with(@debate)
  end

  #def destroy
  #  @debate = Debate.find(params[:id])
  #  @debate.destroy
  #  respond_with(@debate)
  #end
end