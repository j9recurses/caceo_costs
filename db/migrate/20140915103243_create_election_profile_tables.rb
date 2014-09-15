class CreateElectionProfileTables < ActiveRecord::Migration
  def change

    create_table :election_year_profiles do |t|
      t.string :year
      t.date :election_dt
      t.integer :year_dt
      t.string :election_type
      t.timestamps
    end

    create_table :election_profile_descriptions do |t|
      t.string :field
      t.string :label
      t.string :model_name
      t.text :description
     t.timestamps
    end

    create_table :election_profiles do |t|
     t.string :epems
    t.boolean :eppphwscan
    t.boolean :eppphwdre
    t.boolean :eppphwmarkd
    t.boolean :eppphwpollbk
    t.boolean :eppphwoth
    t.string :epetallysys
    t.integer :epppbalpap
    t.integer :epppbalaccsd
    t.integer :eprv
    t.integer :eppploc
    t.integer :epprecwpp
    t.integer :epprecvbm
    t.integer :epbaltype
    t.integer :epbalpage
    t.integer :epbalsampvip
    t.integer :epvipinsrt
    t.integer :epbalofficl
    t.integer :epvbmmail
    t.integer :epvbmmailprm
  t.integer :epvbmmailmbp
  t.integer :epvbmmailuo
  t.integer :epvbmotc
  t.integer :epvbmret
  t.integer :epvbmretprm
  t.integer :epvbmretmbp
  t.integer :epvbmretuo
  t.integer :epvbmundel
  t.integer :epvbmchal
  t.integer :epvbmprovc
  t.integer :epvbmprovnc
  t.integer :eplangnoeng
  t.integer :epcand
  t.integer :epcandfsc
  t.integer :epcandcd
    t.integer :epcandwi
    t.integer :epcandwifsc
    t.integer :epcandwicd
    t.integer :epmeasr
    t.integer :epmeasrfsc
    t.integer :epmeasrcd
    t.float :epicrp
    t.boolean :epicrpfed
    t.boolean :epicrpcounty
    t.boolean :epicrpown
    t.boolean :epicrpoth
    t.integer :eptotindirc
    t.integer :eptotelectc
    t.boolean :epcostallrg
    t.boolean :epcostallpre
    t.boolean :epcostallopp
    t.boolean :epcostalloth
    t.integer :eptotbilled
    t.integer :eptotcounty
    t.integer :eptotsb90c
    t.integer :eptotsb90r
    t.text :epmandates
    t.boolean :started,  :default => false
    t.boolean :complete,  :default => false
        t.string :current_step, index: true
        t.integer :county
        t.integer :election_year_profile_id
     t.timestamps
  end



  end
end
