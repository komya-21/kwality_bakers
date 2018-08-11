class AddAttachmentPhoto1Photo2Photo3Photo4Photo5ToWorkorders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :workorders do |t|
      t.attachment :photo1
      t.attachment :photo2
      t.attachment :photo3
      t.attachment :photo4
      t.attachment :photo5
    end
  end

  def self.down
    remove_attachment :workorders, :photo1
    remove_attachment :workorders, :photo2
    remove_attachment :workorders, :photo3
    remove_attachment :workorders, :photo4
    remove_attachment :workorders, :photo5
  end
end
