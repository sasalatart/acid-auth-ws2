class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def human_errors
    errors.full_messages.join(', ')
  end
end
