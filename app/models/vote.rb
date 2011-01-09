class Vote < ActiveRecord::Base
  belongs_to :argument, :counter_cache => true
end
