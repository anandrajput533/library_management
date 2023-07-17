class Book < ApplicationRecord
	belongs_to :library
	enum category: { novel: 0, biography: 1, fantasy: 2, mystery: 3 }
end
