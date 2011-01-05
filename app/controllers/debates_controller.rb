class DebatesController < ApplicationController
  layout 'one_col'
  respond_to :html

  def index
  	unless params[:search].nil?
  		@debates = Debate.paginate :page => params[:page], :order => 'created_at DESC', :conditions => ['name LIKE ?', "%#{params[:search]}%"]
  	else
  		@debates = Debate.paginate :page => params[:page], :order => 'created_at DESC'
  	end
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
  	unless current_user.nil?
		@debate = Debate.new
		2.times { @debate.sides.build }
		respond_with(@debate)
	else
		flash[:error] = "You need to be logged in to create a debate."
		redirect_to debates_path
	end
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