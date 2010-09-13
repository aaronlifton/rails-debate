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

  def edit
    @argument = Argument.find(params[:id])
    @debate = @argument.side.debate    
    respond_with(@argument)
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

  def destroy
    @argument = Argument.find(params[:id])
    @argument.destroy
    respond_with(@argument)
  end
end