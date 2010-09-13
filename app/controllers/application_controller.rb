class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  layout 'one_col'
end