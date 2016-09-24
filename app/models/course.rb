# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string
#  short_link :string
#  manager_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :posts
  has_many :course_users
  has_many :users, :through => :course_users
  belongs_to :manager, :class_name => "User", :foreign_key => :manager_id

	after_create :generate_short_link

  def join(user)
    cu = CourseUser.where(:course_id => self.id, :user_id => user.id).first
    if cu.nil?
      cu = CourseUser.new
      cu.user = user
      cu.course = self
      cu.save
    end
    cu
  end

  def leave(user)
    cu = CourseUser.where(:course_id => self.id, :user_id => user.id).first
    cu.delete if !cu.nil?
  end

  def ios_link_course_url
    url_for(controller: 'courses',
            action: 'join',
            id: self.id,
            only_path: false)
  end

	def generate_short_link
		link = self.ios_link_course_url
		bitly = Bitly.new("deepcheck", KEYS['bitly'])

		shorten = bitly.shorten(link)

		self.short_link = shorten.short_url
		self.save
	end
end
