class DeviseTokenAuthCreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table(:teachers) do |t|
      ## Required
      t.string :provider, :null => false, :default => "institutional_user"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_institutional_user # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :institutional_user or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name
      t.string :lastname
      t.string :institutional_user

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :teachers, :institutional_user,   unique: true
    add_index :teachers, [:uid, :provider],     unique: true
    add_index :teachers, :reset_password_token, unique: true
    add_index :teachers, :confirmation_token,   unique: true
    # add_index :teachers, :unlock_token,       unique: true
  end
end
