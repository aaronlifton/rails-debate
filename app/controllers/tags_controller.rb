class TagsController < ApplicationController
 	respond_to :html

	def index
		@tags = Debate.tag_counts_on(:tags).paginate :page => params[:page], :per_page => 100
		respond_with(@tags) do |format|
        	format.html { render :layout => "one_col" }
        end		
	end
	
	def show
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
		
		@tag = params[:id]
		@debates = @debates.select {|d| d.tags.map(&:name).include?(@tag)}.paginate :page => params[:page]
		@top_debates = Debate.top[0..9]
    	@tags = Debate.tag_counts_on(:tags)[0..19]
		respond_with(@tag) do |format|
        	format.html { render :layout => "three_col" }
        end
    end
end
