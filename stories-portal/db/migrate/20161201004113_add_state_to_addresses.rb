class AddStateToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :state, foreign_key: true, index: true, after: :customer_id
  end
end
