# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140812141501) do

  create_table "access_codes", force: true do |t|
    t.string   "user_access_code"
    t.string   "access_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ca_county_infos", force: true do |t|
    t.string  "name"
    t.integer "fips"
    t.string  "url"
  end

  create_table "categories", force: true do |t|
    t.string   "cost_type"
    t.string   "name"
    t.string   "model_name"
    t.boolean  "started",          default: false
    t.boolean  "complete",         default: false
    t.integer  "model_total"
    t.integer  "county"
    t.integer  "election_year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_descriptions", force: true do |t|
    t.string   "field"
    t.string   "name"
    t.string   "label"
    t.text     "description"
    t.string   "model_name"
    t.string   "cost_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "election_years", force: true do |t|
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filter_costs", force: true do |t|
    t.text     "fieldlist"
    t.string   "filtertype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postages", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "sspossbal"
    t.integer  "ssposuo"
    t.integer  "ssposvbmo"
    t.integer  "ssposvbmi"
    t.integer  "ssposvbmoth"
    t.integer  "ssposoth"
    t.text     "ssposcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salbals", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salbaldesign"
    t.integer  "salbaltrans"
    t.integer  "salbalorder"
    t.integer  "salbalmail"
    t.integer  "salbalother"
    t.integer  "salbalpsrp"
    t.integer  "salbalpsop"
    t.integer  "salbaltsrp"
    t.integer  "salbaltsop"
    t.integer  "salbaltotbe"
    t.integer  "salbaltotbep"
    t.integer  "salbalbeps"
    t.integer  "salbalbepsp"
    t.integer  "salbalbets"
    t.integer  "salbalbetsp"
    t.integer  "salbaltothrs"
    t.integer  "salbalhrsps"
    t.integer  "salbalhrsts"
    t.text     "salbalcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_step"
  end

  create_table "salbcs", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salbcinh"
    t.integer  "salbcamor"
    t.integer  "salbcchca"
    t.integer  "salbcsec"
    t.integer  "sabcoth"
    t.integer  "salbcpsrp"
    t.integer  "salbcpsop"
    t.integer  "salbctsrp"
    t.integer  "salbctsop"
    t.integer  "salbctotbe"
    t.integer  "salbctotbep"
    t.integer  "salbcbeps"
    t.integer  "salbcbepsp"
    t.integer  "salbcbets"
    t.integer  "salbcbetsp"
    t.integer  "salbctothrs"
    t.integer  "salbchrsps"
    t.integer  "salbchrsts"
    t.text     "salbccomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salcans", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salcanprep"
    t.integer  "salcanproc"
    t.integer  "slacanoth"
    t.integer  "salcanpsrp"
    t.integer  "salcanpsop"
    t.integer  "salcantsrp"
    t.integer  "salcantsop"
    t.integer  "salcanbe"
    t.integer  "salcanbep"
    t.integer  "salcanbeps"
    t.integer  "salcanbepsp"
    t.integer  "salcanbets"
    t.integer  "salcanbetsp"
    t.integer  "salcantothrs"
    t.integer  "salcanhrsps"
    t.integer  "salcanhrsts"
    t.text     "salcancomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saldojos", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "saldojomc"
    t.integer  "saldojopsrp"
    t.integer  "saldojopsop"
    t.integer  "saldojotsrp"
    t.integer  "saldojotsop"
    t.integer  "saldojobe"
    t.integer  "saldojobep"
    t.integer  "saldojobeps"
    t.integer  "saldojobepsp"
    t.integer  "saldojobets"
    t.integer  "saldojobetsp"
    t.integer  "saldojohrs"
    t.integer  "saldojohrsps"
    t.integer  "saldojohrsts"
    t.text     "saldojocomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salmeds", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salmedprep"
    t.integer  "salmedhandl"
    t.integer  "salmedpsrp"
    t.integer  "salmedpsop"
    t.integer  "salmedtsrp"
    t.integer  "salmedtsop"
    t.integer  "salmedbe"
    t.integer  "salmedbep"
    t.integer  "salmedbeps"
    t.integer  "salmedbepsp"
    t.integer  "salmedbets"
    t.integer  "salmedbetsp"
    t.integer  "salmedhrs"
    t.integer  "salmedhrsps"
    t.integer  "salmedhrsts"
    t.text     "salmedcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saloths", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salothvoed"
    t.integer  "salothvore"
    t.integer  "salothelcal"
    t.integer  "salothstind"
    t.integer  "salothvoros"
    t.integer  "salother"
    t.integer  "salothpsrp"
    t.integer  "salothpsop"
    t.integer  "salothtsrp"
    t.integer  "salothtsop"
    t.integer  "salothbe"
    t.integer  "salothbep"
    t.integer  "salothbeps"
    t.integer  "salothbepsp"
    t.integer  "salothbets"
    t.integer  "salothbetsp"
    t.integer  "salothhrs"
    t.integer  "salothhrsps"
    t.integer  "salothhrsts"
    t.text     "salothcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salpps", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salppsurvey"
    t.integer  "salpporder"
    t.integer  "salppve"
    t.integer  "salppdelve"
    t.integer  "salpppay"
    t.integer  "salpppubnot"
    t.integer  "salppoth"
    t.integer  "salpppsrp"
    t.integer  "salpppsop"
    t.integer  "salpptsrp"
    t.integer  "salpptsop"
    t.integer  "salpptotbe"
    t.integer  "salpptotbep"
    t.integer  "salppbeps"
    t.integer  "salppbepsp"
    t.integer  "salppbets"
    t.integer  "salppbetsp"
    t.integer  "salpptothrs"
    t.integer  "salpphrsps"
    t.integer  "salpphrsts"
    t.text     "salppcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salpws", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salpwrec"
    t.integer  "salpwdvtrain"
    t.integer  "salpwtrain"
    t.integer  "salpwpay"
    t.integer  "salpwoth"
    t.integer  "salpwpsrp"
    t.integer  "salpwpsop"
    t.integer  "salpwtsrp"
    t.integer  "salpwrtsop"
    t.integer  "salpwtotbe"
    t.integer  "salpwtotbep"
    t.integer  "salpwbeps"
    t.integer  "salpwbepsp"
    t.integer  "salpwbets"
    t.integer  "salpwbetsp"
    t.integer  "salpwtothrs"
    t.integer  "salpwhrsps"
    t.integer  "salpwhrsts"
    t.text     "salpwhcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salvbms", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "salvbmoutr"
    t.integer  "salvbmappro"
    t.integer  "salvbmuoapp"
    t.integer  "salvbmusps"
    t.integer  "salvbmproces"
    t.integer  "salvbmoth"
    t.integer  "salvbmpsrp"
    t.integer  "salvbmpsop"
    t.integer  "salvbmtsrp"
    t.integer  "salvbmtsop"
    t.integer  "salvbmtotbe"
    t.integer  "salvbmtotbep"
    t.integer  "salvbmbeps"
    t.integer  "salvbmbepsp"
    t.integer  "salvbmbets"
    t.integer  "salvbmbetsp"
    t.integer  "salvbmtothrs"
    t.integer  "salvbmhrsps"
    t.integer  "salvbmhrsts"
    t.text     "salvbmcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssbals", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "ssballayout"
    t.integer  "ssbaltransl"
    t.integer  "ssbalpri"
    t.integer  "ssbalprisb"
    t.integer  "ssbalprisben"
    t.integer  "ssbalprisbch"
    t.integer  "ssbalprisbko"
    t.integer  "ssbalprisbsp"
    t.integer  "ssbalrpisbvi"
    t.integer  "ssbalprisbja"
    t.integer  "ssbalprisbta"
    t.integer  "ssbalprisbkh"
    t.integer  "ssbalprisbhi"
    t.integer  "ssbalprisbth"
    t.integer  "ssbalprisbfi"
    t.integer  "ssbalprisbml"
    t.integer  "ssbalpriob"
    t.integer  "ssbalprioben"
    t.integer  "ssbalpriobch"
    t.integer  "ssbalpriobko"
    t.integer  "ssbalpriobsp"
    t.integer  "ssbalpriobvi"
    t.integer  "ssbalpriobja"
    t.integer  "ssbalpriobta"
    t.integer  "ssbalpriobkh"
    t.integer  "ssbalpriobhi"
    t.integer  "ssbalpriobth"
    t.integer  "ssbalpriobfi"
    t.integer  "ssbalpriobml"
    t.integer  "ssbalprivbm"
    t.integer  "ssbalpriuo"
    t.integer  "ssbalpriprot"
    t.integer  "ssbalpriprou"
    t.integer  "ssbalpriship"
    t.integer  "ssbalprioth"
    t.text     "ssbalcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sscans", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "sscanprint"
    t.text     "sscancomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssmeds", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "ssmedprint"
    t.text     "ssmedcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssoths", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "ssothoutrea"
    t.integer  "ssothbcounth"
    t.integer  "ssothbcsec"
    t.integer  "ssothwareh"
    t.integer  "ssothelcom"
    t.integer  "ssothphbank"
    t.integer  "ssothwebsite"
    t.integer  "ssothcpst"
    t.integer  "ssothoth"
    t.text     "ssothcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sspps", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "ssppsurvey"
    t.integer  "sspprent"
    t.integer  "ssppmod"
    t.integer  "ssppdelive"
    t.integer  "ssppsup"
    t.integer  "ssppsec"
    t.integer  "ssppoth"
    t.text     "ssppcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sspws", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "sspwrec"
    t.integer  "sspwtrain"
    t.integer  "sspwcomp"
    t.integer  "sspwoth"
    t.text     "sspwcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssvehs", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county"
    t.integer  "ssvehrent"
    t.integer  "ssvehcount"
    t.integer  "ssvehfuel"
    t.integer  "ssvehins"
    t.text     "ssvehcomment"
    t.string   "current_step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "county"
    t.string   "security_answer"
    t.string   "security_question"
    t.string   "access_code"
    t.boolean  "reset_password",     default: false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "year_elements", force: true do |t|
    t.integer "element_id"
    t.integer "election_year_id"
    t.string  "element_type"
  end

end
