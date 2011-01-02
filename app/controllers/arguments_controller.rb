class ArgumentsController < ApplicationController
  layout 'one_col'
  respond_to :html, :js

  def index
    respond_with(@arguments = Argument.all)
  end

  def show
    respond_with(@argument = Argument.find(params[:id]))
  end

  def new
    redirect_to root_path
  end
  
  def reply
    @parent = Argument.find(params[:id])
    @argument = @parent.children.build
    @debate = @parent.debate
    respond_with(@argument) do |format|
      format.html { redirect_to argument_path(@parent) }
    end
  end

  def create
    @argument = Argument.new(params[:argument])
    @debate = @argument.debate || Debate.find(params[:debate_id].to_i)
    flash[:notice] = "Argument successfully created" if @argument.save
    respond_with(@argument) do |format|
      format.html { redirect_to debate_path(@debate) } if @argument.valid?
    end
  end

  def update
    @argument = Argument.find(params[:id])
    @argument.update_attributes(params[:argument])
    respond_with(@argument)
  end
  
  def vote
  	success = false
  	@argument = Argument.find(params[:id])
  	if current_user != nil
	  old_vote = Vote.first(:conditions => {:argument_id => @argument.id, :user_id => current_user.id})
	  if !old_vote.nil?
	  	error = "You have already voted for that argument."
	  elsif @argument.user_id == current_user.id
	  	error = "You cannot vote for your own arguments."
	  else
	  	@vote = Vote.new(:argument_id => @argument.id, :user_id => current_user.id)
	  	success = @vote.save
	  end
	else
		error = "You need to be logged in to vote."
	end
	@result = {:score => @argument.score, :success => success, :error => error}
  	if request.xhr?
  		render :text => @result.to_json
  	else
  		redirect_to debate_path(@argument.debate)
  	end
  end
  
  def destroy
  	if current_user != nil && current_user.name == "flubba"
		@argument = Argument.find(params[:id])
		@argument.destroy
		respond_with(@argument)
	else
		redirect_to root_path
	end
  end
end