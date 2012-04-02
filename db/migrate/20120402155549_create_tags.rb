class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

    end
    
    create_table :tags_tickets, :id => false do |t|
      t.integer :ticket_id, :tag_id
    end
  end
end
