class RenameShippingFeeBurdenIdToItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :shipping_fee_burden_id, :shipping_fee_id
end
end
