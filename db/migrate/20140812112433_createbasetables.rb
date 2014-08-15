class Createbasetables < ActiveRecord::Migration
###initial migration to set up db
  def change

    #county_infos_table
    create_table :ca_county_infos do |t|
      t.string :name
      t.integer :fips
      t.string :url
    end

      #sessions table
    create_table :sessions do |t|
      t.string :session_id, :null => false, :unique => true
      t.text :data
      t.timestamps
    end

    create_table :access_codes do  |t |
      t.string :user_access_code
      t.string :access_type
      t.timestamps
    end

    #election_years
    create_table :election_years do |t|
      t.integer :year
      t.timestamps
    end

    #users
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.integer :county,  index: true
      t.string :security_answer
      t.string :security_question
      t.string :access_code
      t.boolean :reset_password,  :default => false
      t.string :status
      t.timestamps
    end

  #cost categories
  create_table :category_descriptions do |t|
    t.string :field
    t.string :name
    t.string :label
    t.text :description
    t.string :model_name
    t.string :cost_type
    t.timestamps
  end

  ##category years
  create_table :categories do | t|
    t.string :cost_type
    t.string :name
    t.string :model_name
    t.boolean :started,  :default => false
    t.boolean :complete,  :default => false
    t.integer :model_total
    t.integer :county
    t.integer :election_year_id,  references: :election_years,  index: true
    t.timestamps
  end

   create_table :year_elements do |t|
      t.integer :element_id
      t.integer :election_year_id ,  references: :election_years,  index: true
      t.string :element_type
    end

  end
end



