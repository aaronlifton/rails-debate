class User < ActiveRecord::Base
	validates :name, :presence => true,
			   		 :format => { :with =>  /^\w+$/i, :message => "can only contain letters, numbers, and underscores." },
			   		 :length => { :maximum => 30 }
	
	has_many :arguments
	has_many :debates
	
  include Clearance::User
  
  def to_param
  	name
  end
    
	def email_optional?
		true
	end
	
	def send_confirmation_email
		nil
	end
	
	def self.authenticate(name, password)
		return nil unless user = find_by_name(name)
		return user if user.authenticated?(password)
	end
	
	def sides
	  arguments.map {|a| a.side}.uniq
	end
	
	def points
		arguments.map {|a| a.score}.inject {|sum, n| sum + n }
	end
	
	def voted_for(id)
		old = Vote.first(:conditions => {:argument_id => id, :user_id => self.id})
		return old.nil?
	end
end