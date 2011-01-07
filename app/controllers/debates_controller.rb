class DebatesController < ApplicationController
  layout 'one_col'
  respond_to :html

  def index
    unless params[:sort].nil?
  		if params[:sort] == "arguments"
  			@debates = Debate.all.sort_by {|d| d.argument_count}.reverse
  		elsif params[:sort] == "hot"
  			@debates = Debate.hot
  		else
  			if params[:reverse] == "true"
  				@debates = Debate.order("created_at DESC")
  			else
  			  	@debates = Debate.order("created_at ASC")
			end
  		end
  	else
  		@debates = Debate.all
  	end
  	@debates.reverse! if params[:reverse] == "true" && params[:sort] != "date"
  	
  	unless params[:search].nil?
  		@debates = @debates.paginate :page => params[:page], :order => 'created_at DESC', :conditions => ['name LIKE ?', "%#{params[:search]}%"]
  	else
  		@debates = @debates.paginate :page => params[:page]
  	end

    @tags = Debate.tag_counts_on(:tags)[0..19]
    respond_with(@debates) do |format|
    	format.html { render :layout => "three_col" }
    end
  end

  def show
    @debate = Debate.find(params[:id])
    @argument = Argument.new
    @related = @debate.related
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