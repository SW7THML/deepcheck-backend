class AddAttachmentToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :attachment, :string
  end
end
