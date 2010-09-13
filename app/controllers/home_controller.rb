class HomeController < ApplicationController
  respond_to :html
  layout 'three_col'

  def index
    respond_with(@debates = Debate.hot[0..4])
  end

end
