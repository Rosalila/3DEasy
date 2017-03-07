class UserInPrintingHub < ApplicationRecord
  belongs_to :user
  belongs_to :printing_hub 
end
