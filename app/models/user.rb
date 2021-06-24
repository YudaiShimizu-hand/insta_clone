class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
end
