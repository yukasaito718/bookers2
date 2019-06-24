class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|

      t.timestamps
      t.text :title#本のタイトル
      t.text :body#本の感想
      t.text :image_id#本の画像
      t.integer :user_id
    end
  end
end
