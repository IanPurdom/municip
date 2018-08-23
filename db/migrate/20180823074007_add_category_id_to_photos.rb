class AddCategoryIdToPhotos < ActiveRecord::Migration[5.1]
  def change
  	 add_reference :photos, :category, foreign_key: true
  end
end
