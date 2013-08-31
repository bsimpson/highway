require 'securerandom'

class Example < ActiveRecord::Base
  attr_accessible :route, :grep
  validates :slug, uniqueness: true
  before_validation :generate_slug, unless: :slug_present?

  private

  def slug_present?
    self.slug.present?
  end

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(8)
  end
end
