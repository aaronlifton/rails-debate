class Argument < ActiveRecord::Base
  	cattr_reader :per_page
  	@@per_page = 1
  	
    validates :body, :presence => true,
                     :length => { :minimum => 50, :maximum => 2500 }
                     
    belongs_to :side
    belongs_to :user
    has_many :votes
    
    validate :has_side
    
    acts_as_tree :order => "id"
    
    before_save :markdownize_description,
        :unless => Proc.new { |argument| argument.body.blank? }
    
    def debate
        side.debate unless side.nil?
    end
    
    def has_side
        errors[:base] << "An argument must have a side" if side.nil?
    end
    
    def markdownize_description
        #body = Markdown.new(body).to_html
    end
    
    def score
    	return votes.count
    end
end
