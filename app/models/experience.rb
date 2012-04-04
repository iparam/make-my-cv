class Experience
  include Mongoid::Document
  field :company_name, :type => String
  field :title, :type => String
  field :location, :type => String
  field :is_current, :type => Boolean
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :description, :type => String
  embedded_in :user       
end
