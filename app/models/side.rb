class Side < ActiveRecord::Base
    validates :name, :presence => true,
                     :length => { :minimum => 2, :unless => Proc.new { |s| s.name.blank? } }
                     
    belongs_to :debate
    has_many :arguments
        
    before_save :markdownize_description,
        :unless => Proc.new { |side| side.description.blank? }
    
    def parent_arguments
        arguments.where("parent_id IS NULL")
    end
    
    def markdownize_description
        #description = Markdown.new(description).to_html
    end
    
    def fields
        fields = ActiveSupport::OrderedHash.new
        fields['name'] = { :type => 'text_field', :destroy => true }
    end
end
