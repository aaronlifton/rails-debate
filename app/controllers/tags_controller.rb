class TagsController < ApplicationController
 	respond_to :html

	def index
		@tags = Debate.tag_counts_on(:tags).paginate :page => params[:page], :per_page => 100
		respond_with(@tags) do |format|
        	format.html { render :layout => "one_col" }
        end		
	end
	
	def show
		@tag = params[:id]
		@debates = Debate.tagged_with(@tag).paginate :page => params[:page], :order => "created_at DESC"
		respond_with(@tag) do |format|
        	format.html { render :layout => "one_col" }
        end
    end
end
