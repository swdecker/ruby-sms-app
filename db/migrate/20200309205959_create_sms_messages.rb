class CreateSmsMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :sms_messages do |t|

      t.timestamps
    end
  end
end
