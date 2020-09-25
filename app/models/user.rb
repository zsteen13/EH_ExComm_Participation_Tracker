class User < ApplicationRecord
  # supplied by email_validator gem
  validates :email, email: true

  def email=(e)
    e = e.strip if e
    super(e)
  end
end
