class Employee < ApplicationRecord
  establish_connection "production".to_sym
end
