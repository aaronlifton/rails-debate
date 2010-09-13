class Debate < ActiveRecord::Base
    validates :name, :presence => true,
                     :length => { :minimum => 5, :unless => Proc.new { |d| d.name.blank? } }
    
    has_many :sides, :dependent => :destroy
    accepts_nested_attributes_for :sides, :allow_destroy => true#, :reject_if => proc { |side| side['name'].blank? }
    #validate :has_at_least_two_sides
    validate :has_enough_sides
    
    belongs_to :user
    has_many :arguments, :through => :sides
        
    before_save :markdownize_description,
        :unless => Proc.new { |debate| debate.description.blank? }
    
    def arguments
      sides.map { |s| s.arguments }.flatten
    end
    
    def parent_arguments
        arguments.where("parent_id IS NULL")
    end
    
    def has_enough_sides
        #unmarked_sides = sides.select { |side| side.marked_for_destruction? != true }
        unmarked_sides = sides
        errors[:sides] << "A debate must have at least 2 sides." if unmarked_sides.size < 2
    end
    
    def self.hot
        Debate.all.sort_by { |d|
            (d.argument_count.to_f) / ((Time.now.to_i - Time.at(d.created_at.to_i).to_i).to_f / 86400.to_f)
        }.reverse
    end
    
    def argument_count
        Argument.where("side_id in (?)", sides.map(&:id)).count
    end
    
    def markdownize_description
        #description = Markdown.new(description).to_html
    end
    
    def build_enough_sides
        if sides.size < 2
            n = 2 - sides.size
            n.times { sides.build }
        end
    end
    
    def self.fields
        fields = ActiveSupport::OrderedHash.new
        fields['name'] = { :type => 'text_field' }
        fields['description'] = { :type => 'text_area', :hint => "(<a href='http://daringfireball.net/projects/markdown/syntax'>Markdown</a>)" }
        fields
    end
end
