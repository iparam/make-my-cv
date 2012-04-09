class Project
  include Mongoid::Document
  field :name,:type => String
  field :company_name, :type => String
  field :project_url, :type => String
  field :is_ongoing, :type => Boolean
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :description, :type => String
  embedded_in :user    
  validates_presence_of :name
  validates_presence_of :end_date,:if => Proc.new { |exp| exp.is_ongoing == false }
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date
    if end_date && start_date && end_date < start_date
      errors.add(:end_date, "End Date should be greater than Start Date") 
    end
  end
end
