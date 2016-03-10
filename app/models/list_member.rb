class ListMember < ActiveRecord::Base
  belongs_to :list_file, inverse_of: :list_members

  validates :list_file, presence: true
  validates :number, format: /\A[\d]{10}\z/

end
