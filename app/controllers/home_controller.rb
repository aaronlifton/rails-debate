class HomeController < ApplicationController
  respond_to :html
  layout 'three_col'

  def index
    @debates = Debate.hot[0..9]
    @latest_debates = Debate.order("created_at DESC").limit(10)
    @top_debates = Debate.top[0..9]
    @tags = Debate.tag_counts_on(:tags)[0..19]
    respond_with(@debates)
  end

end
