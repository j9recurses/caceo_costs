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

ActiveRecord::Schema.define(version: 20141222081212) do

  create_table "access_codes", force: true do |t|
    t.string   "user_access_code"
    t.string   "access_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "county_id"
  end

  create_table "announcements", force: true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
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
    t.string   "question_type"
  end

  create_table "election_profile_descriptions", force: true do |t|
    t.string   "field"
    t.string   "label"
    t.string   "model_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fieldtype"
  end

  create_table "election_profiles", force: true do |t|
    t.string   "epems"
    t.boolean  "eppphwscan"
    t.boolean  "eppphwdre"
    t.boolean  "eppphwmarkd"
    t.boolean  "eppphwpollbk"
    t.boolean  "eppphwoth"
    t.string   "epetallysys"
    t.integer  "epppbalpap"
    t.integer  "epppbalaccsd"
    t.integer  "eprv"
    t.integer  "eppploc"
    t.integer  "epprecwpp"
    t.integer  "epprecvbm"
    t.integer  "epbaltype"
    t.string   "epbalpage"
    t.integer  "epbalsampvip"
    t.integer  "epvipinsrt"
    t.integer  "epbalofficl"
    t.integer  "epvbmmail"
    t.integer  "epvbmmailprm"
    t.integer  "epvbmmailmbp"
    t.integer  "epvbmmailuo"
    t.integer  "epvbmotc"
    t.integer  "epvbmret"
    t.integer  "epvbmretprm"
    t.integer  "epvbmretmbp"
    t.integer  "epvbmretuo"
    t.integer  "epvbmundel"
    t.integer  "epvbmchal"
    t.integer  "epvbmprovc"
    t.integer  "epvbmprovnc"
    t.integer  "epcand"
    t.integer  "epcandfsc"
    t.integer  "epcandcd"
    t.integer  "epcandwi"
    t.integer  "epcandwifsc"
    t.integer  "epcandwicd"
    t.integer  "epmeasr"
    t.integer  "epmeasrfsc"
    t.integer  "epmeasrcd"
    t.decimal  "epicrp",                   precision: 6, scale: 2
    t.boolean  "epicrpfed"
    t.boolean  "epicrpcounty"
    t.boolean  "epicrpown"
    t.boolean  "epicrpoth"
    t.integer  "eptotindirc"
    t.integer  "eptotelectc"
    t.boolean  "epcostallrg"
    t.boolean  "epcostallpre"
    t.boolean  "epcostallopp"
    t.boolean  "epcostalloth"
    t.integer  "eptotbilled"
    t.integer  "eptotcounty"
    t.integer  "eptotsb90c"
    t.integer  "eptotsb90r"
    t.text     "epmandates"
    t.boolean  "started",                                          default: false
    t.boolean  "complete",                                         default: false
    t.string   "current_step"
    t.integer  "county_id"
    t.integer  "election_year_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "epppbalpapar"
    t.boolean  "epppbalpapbu"
    t.boolean  "epppbalpapot"
    t.integer  "epvbmretpp"
    t.integer  "epvbmirevl"
    t.integer  "epvbmrrevl"
    t.integer  "epprovcwbt"
    t.integer  "epprovcwp"
    t.integer  "epprovncvnr"
    t.integer  "epprovncbrva"
    t.integer  "epprovncoth"
    t.integer  "epprovvbm"
    t.integer  "epprovnor"
    t.integer  "epprovhava"
    t.integer  "epprovunivs"
    t.integer  "epprovoutr"
    t.integer  "epcanvdrere"
    t.integer  "eplangvra"
    t.integer  "eplangcaec"
    t.text     "eplangloc"
    t.integer  "eptotcandca"
    t.integer  "eptotvolunth"
  end

  create_table "election_technologies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "election_year_profiles", force: true do |t|
    t.string   "year"
    t.date     "election_dt"
    t.integer  "year_dt"
    t.string   "election_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edate_full"
  end

  create_table "election_years", force: true do |t|
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "election_dt"
    t.integer  "year_dt"
    t.string   "election_type"
    t.string   "edate_full"
  end

  create_table "filter_costs", force: true do |t|
    t.text     "fieldlist"
    t.string   "filtertype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postages", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "sspossbal"
    t.integer  "ssposuo"
    t.integer  "ssposvbmo"
    t.integer  "ssposvbmi"
    t.integer  "ssposvbmoth"
    t.integer  "ssposoth"
    t.text     "ssposcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssposaddsepm"
    t.boolean  "sspossbal_na",     default: false, null: false
    t.boolean  "ssposuo_na",       default: false, null: false
    t.boolean  "ssposvbmo_na",     default: false, null: false
    t.boolean  "ssposvbmi_na",     default: false, null: false
    t.boolean  "ssposvbmoth_na",   default: false, null: false
    t.boolean  "ssposoth_na",      default: false, null: false
    t.boolean  "ssposaddsepm_na",  default: false, null: false
  end

  create_table "role_assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salbals", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "salbaldesign"
    t.integer  "salbaltrans"
    t.integer  "salbalorder"
    t.integer  "salbalmail"
    t.integer  "salbalother"
    t.integer  "salbalpsrp"
    t.integer  "salbalpsop"
    t.integer  "salbaltsrp"
    t.integer  "salbaltsop"
    t.integer  "salbalbeps"
    t.integer  "salbalbepsp"
    t.integer  "salbalbets"
    t.integer  "salbalbetsp"
    t.integer  "salbalhrsps"
    t.integer  "salbalhrsts"
    t.text     "salbalcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salbaldesign_na",  default: false, null: false
    t.boolean  "salbaltrans_na",   default: false, null: false
    t.boolean  "salbalorder_na",   default: false, null: false
    t.boolean  "salbalmail_na",    default: false, null: false
    t.boolean  "salbalother_na",   default: false, null: false
    t.boolean  "salbalpsrp_na",    default: false, null: false
    t.boolean  "salbalpsop_na",    default: false, null: false
    t.boolean  "salbaltsrp_na",    default: false, null: false
    t.boolean  "salbaltsop_na",    default: false, null: false
    t.boolean  "salbalbeps_na",    default: false, null: false
    t.boolean  "salbalbepsp_na",   default: false, null: false
    t.boolean  "salbalbets_na",    default: false, null: false
    t.boolean  "salbalbetsp_na",   default: false, null: false
    t.boolean  "salbalhrsps_na",   default: false, null: false
    t.boolean  "salbalhrsts_na",   default: false, null: false
  end

  create_table "salbcs", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "salbcsec"
    t.integer  "sabcoth"
    t.integer  "salbcpsrp"
    t.integer  "salbcpsop"
    t.integer  "salbctsrp"
    t.integer  "salbctsop"
    t.integer  "salbcbeps"
    t.integer  "salbcbepsp"
    t.integer  "salbcbets"
    t.integer  "salbcbetsp"
    t.integer  "salbchrsps"
    t.integer  "salbchrsts"
    t.text     "salbccomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salbcnvbmp"
    t.integer  "salbcvbm"
    t.integer  "salbcprov"
    t.integer  "salbcprocpb"
    t.integer  "salbccanvdb"
    t.integer  "salbccanvone"
    t.integer  "salbccanvdre"
    t.integer  "salbccanvpa"
    t.integer  "salbccanvsa"
    t.integer  "salbccanvva"
    t.integer  "salbccanvoth"
    t.boolean  "salbcsec_na",      default: false, null: false
    t.boolean  "sabcoth_na",       default: false, null: false
    t.boolean  "salbcpsrp_na",     default: false, null: false
    t.boolean  "salbcpsop_na",     default: false, null: false
    t.boolean  "salbctsrp_na",     default: false, null: false
    t.boolean  "salbctsop_na",     default: false, null: false
    t.boolean  "salbcbeps_na",     default: false, null: false
    t.boolean  "salbcbepsp_na",    default: false, null: false
    t.boolean  "salbcbets_na",     default: false, null: false
    t.boolean  "salbcbetsp_na",    default: false, null: false
    t.boolean  "salbchrsps_na",    default: false, null: false
    t.boolean  "salbchrsts_na",    default: false, null: false
    t.boolean  "salbcnvbmp_na",    default: false, null: false
    t.boolean  "salbcvbm_na",      default: false, null: false
    t.boolean  "salbcprov_na",     default: false, null: false
    t.boolean  "salbcprocpb_na",   default: false, null: false
    t.boolean  "salbccanvdb_na",   default: false, null: false
    t.boolean  "salbccanvone_na",  default: false, null: false
    t.boolean  "salbccanvdre_na",  default: false, null: false
    t.boolean  "salbccanvpa_na",   default: false, null: false
    t.boolean  "salbccanvsa_na",   default: false, null: false
    t.boolean  "salbccanvva_na",   default: false, null: false
    t.boolean  "salbccanvoth_na",  default: false, null: false
  end

  create_table "salcans", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "salcanprep"
    t.integer  "salcanproc"
    t.integer  "slacanoth"
    t.integer  "salcanpsrp"
    t.integer  "salcanpsop"
    t.integer  "salcantsrp"
    t.integer  "salcantsop"
    t.integer  "salcanbeps"
    t.integer  "salcanbepsp"
    t.integer  "salcanbets"
    t.integer  "salcanbetsp"
    t.integer  "salcanhrsps"
    t.integer  "salcanhrsts"
    t.text     "salcancomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salcanprep_na",    default: false, null: false
    t.boolean  "salcanproc_na",    default: false, null: false
    t.boolean  "slacanoth_na",     default: false, null: false
    t.boolean  "salcanpsrp_na",    default: false, null: false
    t.boolean  "salcanpsop_na",    default: false, null: false
    t.boolean  "salcantsrp_na",    default: false, null: false
    t.boolean  "salcantsop_na",    default: false, null: false
    t.boolean  "salcanbeps_na",    default: false, null: false
    t.boolean  "salcanbepsp_na",   default: false, null: false
    t.boolean  "salcanbets_na",    default: false, null: false
    t.boolean  "salcanbetsp_na",   default: false, null: false
    t.boolean  "salcanhrsps_na",   default: false, null: false
    t.boolean  "salcanhrsts_na",   default: false, null: false
  end

  create_table "saldojos", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "saldojomc"
    t.integer  "saldojopsrp"
    t.integer  "saldojopsop"
    t.integer  "saldojotsrp"
    t.integer  "saldojotsop"
    t.integer  "saldojobeps"
    t.integer  "saldojobepsp"
    t.integer  "saldojobets"
    t.integer  "saldojobetsp"
    t.integer  "saldojohrsps"
    t.integer  "saldojohrsts"
    t.text     "saldojocomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "saldojomc_na",     default: false, null: false
    t.boolean  "saldojopsrp_na",   default: false, null: false
    t.boolean  "saldojopsop_na",   default: false, null: false
    t.boolean  "saldojotsrp_na",   default: false, null: false
    t.boolean  "saldojotsop_na",   default: false, null: false
    t.boolean  "saldojobeps_na",   default: false, null: false
    t.boolean  "saldojobepsp_na",  default: false, null: false
    t.boolean  "saldojobets_na",   default: false, null: false
    t.boolean  "saldojobetsp_na",  default: false, null: false
    t.boolean  "saldojohrsps_na",  default: false, null: false
    t.boolean  "saldojohrsts_na",  default: false, null: false
  end

  create_table "salmeds", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
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
    t.integer  "salmedhrsps"
    t.integer  "salmedhrsts"
    t.text     "salmedcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salmedcampm"
    t.boolean  "salmedprep_na",    default: false, null: false
    t.boolean  "salmedhandl_na",   default: false, null: false
    t.boolean  "salmedpsrp_na",    default: false, null: false
    t.boolean  "salmedpsop_na",    default: false, null: false
    t.boolean  "salmedtsrp_na",    default: false, null: false
    t.boolean  "salmedtsop_na",    default: false, null: false
    t.boolean  "salmedbe_na",      default: false, null: false
    t.boolean  "salmedbep_na",     default: false, null: false
    t.boolean  "salmedbeps_na",    default: false, null: false
    t.boolean  "salmedbepsp_na",   default: false, null: false
    t.boolean  "salmedbets_na",    default: false, null: false
    t.boolean  "salmedbetsp_na",   default: false, null: false
    t.boolean  "salmedhrsps_na",   default: false, null: false
    t.boolean  "salmedhrsts_na",   default: false, null: false
    t.boolean  "salmedcampm_na",   default: false, null: false
  end

  create_table "saloths", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
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
    t.integer  "salothbeps"
    t.integer  "salothbepsp"
    t.integer  "salothbets"
    t.integer  "salothbetsp"
    t.integer  "salothhrsps"
    t.integer  "salothhrsts"
    t.text     "salothcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salothvoedm"
    t.integer  "salothvorepr"
    t.integer  "salothrevm"
    t.integer  "salothhotm"
    t.integer  "salothdatam"
    t.boolean  "salothvoed_na",    default: false, null: false
    t.boolean  "salothvore_na",    default: false, null: false
    t.boolean  "salothelcal_na",   default: false, null: false
    t.boolean  "salothstind_na",   default: false, null: false
    t.boolean  "salothvoros_na",   default: false, null: false
    t.boolean  "salother_na",      default: false, null: false
    t.boolean  "salothpsrp_na",    default: false, null: false
    t.boolean  "salothpsop_na",    default: false, null: false
    t.boolean  "salothtsrp_na",    default: false, null: false
    t.boolean  "salothtsop_na",    default: false, null: false
    t.boolean  "salothbeps_na",    default: false, null: false
    t.boolean  "salothbepsp_na",   default: false, null: false
    t.boolean  "salothbets_na",    default: false, null: false
    t.boolean  "salothbetsp_na",   default: false, null: false
    t.boolean  "salothhrsps_na",   default: false, null: false
    t.boolean  "salothhrsts_na",   default: false, null: false
    t.boolean  "salothvoedm_na",   default: false, null: false
    t.boolean  "salothvorepr_na",  default: false, null: false
    t.boolean  "salothrevm_na",    default: false, null: false
    t.boolean  "salothhotm_na",    default: false, null: false
    t.boolean  "salothdatam_na",   default: false, null: false
  end

  create_table "salpps", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
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
    t.integer  "salppbeps"
    t.integer  "salppbepsp"
    t.integer  "salppbets"
    t.integer  "salppbetsp"
    t.integer  "salpphrsps"
    t.integer  "salpphrsts"
    t.text     "salppcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salppemattr"
    t.boolean  "salppsurvey_na",   default: false, null: false
    t.boolean  "salpporder_na",    default: false, null: false
    t.boolean  "salppve_na",       default: false, null: false
    t.boolean  "salppdelve_na",    default: false, null: false
    t.boolean  "salpppay_na",      default: false, null: false
    t.boolean  "salpppubnot_na",   default: false, null: false
    t.boolean  "salppoth_na",      default: false, null: false
    t.boolean  "salpppsrp_na",     default: false, null: false
    t.boolean  "salpppsop_na",     default: false, null: false
    t.boolean  "salpptsrp_na",     default: false, null: false
    t.boolean  "salpptsop_na",     default: false, null: false
    t.boolean  "salppbeps_na",     default: false, null: false
    t.boolean  "salppbepsp_na",    default: false, null: false
    t.boolean  "salppbets_na",     default: false, null: false
    t.boolean  "salppbetsp_na",    default: false, null: false
    t.boolean  "salpphrsps_na",    default: false, null: false
    t.boolean  "salpphrsts_na",    default: false, null: false
    t.boolean  "salppemattr_na",   default: false, null: false
  end

  create_table "salpws", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "salpwrec"
    t.integer  "salpwdvtrain"
    t.integer  "salpwtrain"
    t.integer  "salpwpay"
    t.integer  "salpwoth"
    t.integer  "salpwpsrp"
    t.integer  "salpwpsop"
    t.integer  "salpwtsrp"
    t.integer  "salpwrtsop"
    t.integer  "salpwbeps"
    t.integer  "salpwbepsp"
    t.integer  "salpwbets"
    t.integer  "salpwbetsp"
    t.integer  "salpwhrsps"
    t.integer  "salpwhrsts"
    t.text     "salpwhcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salpwrecm"
    t.boolean  "salpwrec_na",      default: false, null: false
    t.boolean  "salpwdvtrain_na",  default: false, null: false
    t.boolean  "salpwtrain_na",    default: false, null: false
    t.boolean  "salpwpay_na",      default: false, null: false
    t.boolean  "salpwoth_na",      default: false, null: false
    t.boolean  "salpwpsrp_na",     default: false, null: false
    t.boolean  "salpwpsop_na",     default: false, null: false
    t.boolean  "salpwtsrp_na",     default: false, null: false
    t.boolean  "salpwrtsop_na",    default: false, null: false
    t.boolean  "salpwbeps_na",     default: false, null: false
    t.boolean  "salpwbepsp_na",    default: false, null: false
    t.boolean  "salpwbets_na",     default: false, null: false
    t.boolean  "salpwbetsp_na",    default: false, null: false
    t.boolean  "salpwhrsps_na",    default: false, null: false
    t.boolean  "salpwhrsts_na",    default: false, null: false
    t.boolean  "salpwrecm_na",     default: false, null: false
  end

  create_table "salvbms", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
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
    t.integer  "salvbmbeps"
    t.integer  "salvbmbepsp"
    t.integer  "salvbmbets"
    t.integer  "salvbmbetsp"
    t.integer  "salvbmhrsps"
    t.integer  "salvbmhrsts"
    t.text     "salvbmcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salvbmoutr_na",    default: false, null: false
    t.boolean  "salvbmappro_na",   default: false, null: false
    t.boolean  "salvbmuoapp_na",   default: false, null: false
    t.boolean  "salvbmusps_na",    default: false, null: false
    t.boolean  "salvbmproces_na",  default: false, null: false
    t.boolean  "salvbmoth_na",     default: false, null: false
    t.boolean  "salvbmpsrp_na",    default: false, null: false
    t.boolean  "salvbmpsop_na",    default: false, null: false
    t.boolean  "salvbmtsrp_na",    default: false, null: false
    t.boolean  "salvbmtsop_na",    default: false, null: false
    t.boolean  "salvbmbeps_na",    default: false, null: false
    t.boolean  "salvbmbepsp_na",   default: false, null: false
    t.boolean  "salvbmbets_na",    default: false, null: false
    t.boolean  "salvbmbetsp_na",   default: false, null: false
    t.boolean  "salvbmhrsps_na",   default: false, null: false
    t.boolean  "salvbmhrsts_na",   default: false, null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssbals", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
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
    t.integer  "ssbalprivbm"
    t.integer  "ssbalpriuo"
    t.integer  "ssbalpriprot"
    t.integer  "ssbalpriship"
    t.integer  "ssbalprioth"
    t.text     "ssbalcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssbalprisbmc"
    t.integer  "ssbalpriobmc"
    t.decimal  "ssbalpriprou",     precision: 3, scale: 2
    t.integer  "ssbalprisb1ml"
    t.integer  "ssbalprisb2ml"
    t.integer  "ssbalprisb3ml"
    t.integer  "ssbalprisb1mc"
    t.integer  "ssbalprisb2mc"
    t.integer  "ssbalprisb3mc"
    t.integer  "ssbalpriob1ml"
    t.integer  "ssbalpriob2ml"
    t.integer  "ssbalpriob3ml"
    t.integer  "ssbalpriob1mc"
    t.integer  "ssbalpriob2mc"
    t.integer  "ssbalpriob3mc"
    t.boolean  "ssballayout_na",                           default: false, null: false
    t.boolean  "ssbaltransl_na",                           default: false, null: false
    t.boolean  "ssbalpri_na",                              default: false, null: false
    t.boolean  "ssbalprisb_na",                            default: false, null: false
    t.boolean  "ssbalprisben_na",                          default: false, null: false
    t.boolean  "ssbalprisbch_na",                          default: false, null: false
    t.boolean  "ssbalprisbko_na",                          default: false, null: false
    t.boolean  "ssbalprisbsp_na",                          default: false, null: false
    t.boolean  "ssbalrpisbvi_na",                          default: false, null: false
    t.boolean  "ssbalprisbja_na",                          default: false, null: false
    t.boolean  "ssbalprisbta_na",                          default: false, null: false
    t.boolean  "ssbalprisbkh_na",                          default: false, null: false
    t.boolean  "ssbalprisbhi_na",                          default: false, null: false
    t.boolean  "ssbalprisbth_na",                          default: false, null: false
    t.boolean  "ssbalprisbfi_na",                          default: false, null: false
    t.boolean  "ssbalpriob_na",                            default: false, null: false
    t.boolean  "ssbalprioben_na",                          default: false, null: false
    t.boolean  "ssbalpriobch_na",                          default: false, null: false
    t.boolean  "ssbalpriobko_na",                          default: false, null: false
    t.boolean  "ssbalpriobsp_na",                          default: false, null: false
    t.boolean  "ssbalpriobvi_na",                          default: false, null: false
    t.boolean  "ssbalpriobja_na",                          default: false, null: false
    t.boolean  "ssbalpriobta_na",                          default: false, null: false
    t.boolean  "ssbalpriobkh_na",                          default: false, null: false
    t.boolean  "ssbalpriobhi_na",                          default: false, null: false
    t.boolean  "ssbalpriobth_na",                          default: false, null: false
    t.boolean  "ssbalpriobfi_na",                          default: false, null: false
    t.boolean  "ssbalprivbm_na",                           default: false, null: false
    t.boolean  "ssbalpriuo_na",                            default: false, null: false
    t.boolean  "ssbalpriprot_na",                          default: false, null: false
    t.boolean  "ssbalpriship_na",                          default: false, null: false
    t.boolean  "ssbalprioth_na",                           default: false, null: false
    t.boolean  "ssbalpriprou_na",                          default: false, null: false
    t.boolean  "ssbalprisb1ml_na",                         default: false, null: false
    t.boolean  "ssbalprisb2ml_na",                         default: false, null: false
    t.boolean  "ssbalprisb3ml_na",                         default: false, null: false
    t.boolean  "ssbalpriob1ml_na",                         default: false, null: false
    t.boolean  "ssbalpriob2ml_na",                         default: false, null: false
    t.boolean  "ssbalpriob3ml_na",                         default: false, null: false
  end

  create_table "ssbcs", force: true do |t|
    t.integer  "ssbcprocvbh"
    t.integer  "ssbcprocpbh"
    t.integer  "ssbcprocs"
    t.integer  "ssbcbcounth"
    t.integer  "ssbcbcounts"
    t.integer  "ssbccanvh"
    t.integer  "ssbccanvs"
    t.integer  "ssbcpcsec"
    t.text     "ssbccomment"
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ssbcprocvbh_na",   default: false, null: false
    t.boolean  "ssbcprocpbh_na",   default: false, null: false
    t.boolean  "ssbcprocs_na",     default: false, null: false
    t.boolean  "ssbcbcounth_na",   default: false, null: false
    t.boolean  "ssbcbcounts_na",   default: false, null: false
    t.boolean  "ssbccanvh_na",     default: false, null: false
    t.boolean  "ssbccanvs_na",     default: false, null: false
    t.boolean  "ssbcpcsec_na",     default: false, null: false
  end

  create_table "sscans", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "sscanprint"
    t.text     "sscancomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sscanprint_na",    default: false, null: false
  end

  create_table "ssmeds", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "ssmedprint"
    t.text     "ssmedcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssmedcampm"
    t.boolean  "ssmedprint_na",    default: false, null: false
    t.boolean  "ssmedcampm_na",    default: false, null: false
  end

  create_table "ssoths", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "ssothoutrea"
    t.integer  "ssothwareh"
    t.integer  "ssothelcom"
    t.integer  "ssothphbank"
    t.integer  "ssothwebsite"
    t.integer  "ssothcpst"
    t.integer  "ssothoth"
    t.text     "ssothcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssothoutream"
    t.integer  "ssothrevm"
    t.integer  "ssothhotm"
    t.integer  "ssothdatam"
    t.integer  "ssothothm"
    t.boolean  "ssothoutrea_na",   default: false, null: false
    t.boolean  "ssothwareh_na",    default: false, null: false
    t.boolean  "ssothelcom_na",    default: false, null: false
    t.boolean  "ssothphbank_na",   default: false, null: false
    t.boolean  "ssothwebsite_na",  default: false, null: false
    t.boolean  "ssothcpst_na",     default: false, null: false
    t.boolean  "ssothoth_na",      default: false, null: false
    t.boolean  "ssothoutream_na",  default: false, null: false
    t.boolean  "ssothrevm_na",     default: false, null: false
    t.boolean  "ssothhotm_na",     default: false, null: false
    t.boolean  "ssothdatam_na",    default: false, null: false
    t.boolean  "ssothothm_na",     default: false, null: false
  end

  create_table "sspps", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "ssppsurvey"
    t.integer  "sspprent"
    t.integer  "ssppmod"
    t.integer  "ssppdelive"
    t.integer  "ssppsup"
    t.integer  "ssppsec"
    t.integer  "ssppoth"
    t.text     "ssppcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssppsupm"
    t.boolean  "ssppsurvey_na",    default: false, null: false
    t.boolean  "sspprent_na",      default: false, null: false
    t.boolean  "ssppmod_na",       default: false, null: false
    t.boolean  "ssppdelive_na",    default: false, null: false
    t.boolean  "ssppsup_na",       default: false, null: false
    t.boolean  "ssppsec_na",       default: false, null: false
    t.boolean  "ssppoth_na",       default: false, null: false
    t.boolean  "ssppsupm_na",      default: false, null: false
  end

  create_table "sspws", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "sspwrec"
    t.integer  "sspwtrain"
    t.integer  "sspwcomp"
    t.integer  "sspwoth"
    t.text     "sspwcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sspwrecm"
    t.integer  "sspwcompm"
    t.boolean  "sspwrec_na",       default: false, null: false
    t.boolean  "sspwtrain_na",     default: false, null: false
    t.boolean  "sspwcomp_na",      default: false, null: false
    t.boolean  "sspwoth_na",       default: false, null: false
    t.boolean  "sspwrecm_na",      default: false, null: false
    t.boolean  "sspwcompm_na",     default: false, null: false
  end

  create_table "ssvehs", force: true do |t|
    t.integer  "election_year_id"
    t.integer  "county_id"
    t.integer  "ssvehrent"
    t.integer  "ssvehcount"
    t.integer  "ssvehfuel"
    t.integer  "ssvehins"
    t.text     "ssvehcomment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ssvehrent_na",     default: false, null: false
    t.boolean  "ssvehcount_na",    default: false, null: false
    t.boolean  "ssvehfuel_na",     default: false, null: false
    t.boolean  "ssvehins_na",      default: false, null: false
  end

  create_table "tech_voting_machines", force: true do |t|
    t.string   "voting_equip_type"
    t.date     "purchase_dt"
    t.string   "equip_make"
    t.integer  "purchase_price"
    t.integer  "quantity"
    t.string   "offset_funds_src"
    t.integer  "offset_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "county"
    t.boolean  "purchase_price_services"
  end

  create_table "tech_voting_softwares", force: true do |t|
    t.string   "software_item"
    t.date     "purchase_dt"
    t.integer  "purchase_price_hardware"
    t.integer  "purchase_price_software"
    t.integer  "mat_charges"
    t.integer  "labor_costs"
    t.integer  "county"
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
    t.boolean  "reset_password",         default: false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "year_elements", force: true do |t|
    t.integer "element_id"
    t.integer "election_year_id"
    t.string  "element_type"
  end

end
