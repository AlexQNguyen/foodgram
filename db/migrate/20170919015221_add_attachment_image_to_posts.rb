class AddAttachmentImageToPosts < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.attachment :image
    end
  end

  def down
    remove_attachment :posts, :image
  end
end
