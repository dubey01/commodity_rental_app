# frozen_string_literal: true

# Model user class
class User < ApplicationRecord
  has_secure_password
  self.inheritance_column = :_type_disabled # disabling STI for type reserved keyword

  enum type: { lender: 0, renter: 1 }
end
