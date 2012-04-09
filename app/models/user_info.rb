class UserInfo
  include Mongoid::Document
  
  field :first_name
  field :last_name
  field :display_name
  field :headline
  field :goal
  field :specialities
  validates_presence_of :first_name,:last_name,:headline,:goal
  embedded_in  :user
end
