class CreatePurchasers < ActiveRecord::Migration[6.0]
  def change
    create_table :purchasers do |t|
      t.string      :post_code,       null: false
      t.string      :city,            null: false
      t.string      :house_number,    null: false
      t.string      :phone_number,    null: false
      t.integer     :prefecture_id,   null: false
      t.references  :order,           null: false, foreign_key:true
      t.string      :building


      t.timestamps
    end
  end
end
