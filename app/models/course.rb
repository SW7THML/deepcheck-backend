class Course < ApplicationRecord
  include Rails.application.routes.url_helpers

	has_many :posts

	after_create :generate_short_link

  def to_json(options={})
     options[:only] ||= [:name]
     super(options)
   end

  
private
	def generate_short_link
		link = ios_link_course_url(self)
		bitly = Bitly.new("deepcheck", "R_c1be89e5bafc4f868570f3fd1d4089e2")

		shorten = bitly.shorten(link)

		self.short_link = shorten.short_url
		self.save

		# :short_link = url
		# self.short_link = url
	end
end


# http://localhost:3000/courses/3/ios_link


# url = Googl.shorten('http://www.zigotto.com', "213.57.23.49", "google_api_key")
