class Experience
  include Mongoid::Document
  field :company_name, :type => String
  # field :name, :type => String
  field :title, :type => String
  field :location, :type => String
  field :is_current, :type => Boolean
  field :start_date, :type => Date
  field :l_start_date, :type => String
  field :end_date, :type => Date
  field :description, :type => String
  field :industry, :type => String
  field :size, :type => String
  field :company_type, :type => String
  embedded_in :user   
  validates_presence_of :title,:company_name    
  validates_presence_of :start_date
  validates_presence_of :end_date,:if => Proc.new { |exp| exp.is_current == false }
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date

    if end_date && start_date && end_date < start_date
      errors.add(:end_date, "End Date should be greater than Start Date") 
    end
  end
end
