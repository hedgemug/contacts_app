class Contact < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japan_phone_number
    "+81 #{phone_number}"
  end

  def as_json
    {
      id: id,
      full_name: full_name,
      first_name: first_name,
      last_name: last_name,
      middle_name: middle_name,
      email: email,
      bio: bio,
      phone_number: phone_number,
      japan_phone_number: japan_phone_number,
      updated_at: friendly_updated_at
    }
  end

end
