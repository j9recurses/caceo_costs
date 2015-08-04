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

ActiveRecord::Schema.define(version: 20150803125118) do

  create_table "access_codes", force: :cascade do |t|
    t.string   "user_access_code", limit: 255
    t.string   "access_type",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "county_id",        limit: 4
  end

  create_table "announcements", force: :cascade do |t|
    t.text     "message",    limit: 65535
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "cost_type",        limit: 255
    t.string   "name",             limit: 255
    t.string   "table_name",       limit: 255
    t.boolean  "started",          limit: 1,   default: false
    t.boolean  "complete",         limit: 1,   default: false
    t.integer  "model_total",      limit: 4
    t.integer  "county",           limit: 4
    t.integer  "election_year_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["election_year_id"], name: "index_categories_on_election_year_id", using: :btree

  create_table "counties", force: :cascade do |t|
    t.string  "name", limit: 255
    t.integer "fips", limit: 4
    t.string  "url",  limit: 255
  end

  create_table "election_profile_descriptions", force: :cascade do |t|
    t.string   "field",              limit: 255
    t.string   "label",              limit: 255
    t.string   "table_name",         limit: 255
    t.text     "description",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fieldtype",          limit: 255
    t.string   "survey_category",    limit: 255
    t.string   "question_type",      limit: 255
    t.string   "subsection",         limit: 255
    t.integer  "validation_type_id", limit: 4
    t.integer  "survey_id",          limit: 4
  end

  create_table "election_profiles", force: :cascade do |t|
    t.string   "epems",                    limit: 255
    t.boolean  "eppphwscan",               limit: 1
    t.boolean  "eppphwdre",                limit: 1
    t.boolean  "eppphwmarkd",              limit: 1
    t.boolean  "eppphwpollbk",             limit: 1
    t.boolean  "eppphwoth",                limit: 1
    t.string   "epetallysys",              limit: 255
    t.integer  "epppbalpap",               limit: 4
    t.integer  "epppbalaccsd",             limit: 4
    t.integer  "eprv",                     limit: 4
    t.integer  "eppploc",                  limit: 4
    t.integer  "epprecwpp",                limit: 4
    t.integer  "epprecvbm",                limit: 4
    t.integer  "epbaltype",                limit: 4
    t.string   "epbalpage",                limit: 255
    t.integer  "epbalsampvip",             limit: 4
    t.integer  "epvipinsrt",               limit: 4
    t.integer  "epbalofficl",              limit: 4
    t.integer  "epvbmmail",                limit: 4
    t.integer  "epvbmmailprm",             limit: 4
    t.integer  "epvbmmailmbp",             limit: 4
    t.integer  "epvbmmailuo",              limit: 4
    t.integer  "epvbmotc",                 limit: 4
    t.integer  "epvbmret",                 limit: 4
    t.integer  "epvbmretprm",              limit: 4
    t.integer  "epvbmretmbp",              limit: 4
    t.integer  "epvbmretuo",               limit: 4
    t.integer  "epvbmundel",               limit: 4
    t.integer  "epvbmchal",                limit: 4
    t.integer  "epvbmprovc",               limit: 4
    t.integer  "epvbmprovnc",              limit: 4
    t.integer  "epcand",                   limit: 4
    t.integer  "epcandfsc",                limit: 4
    t.integer  "epcandcd",                 limit: 4
    t.integer  "epcandwi",                 limit: 4
    t.integer  "epcandwifsc",              limit: 4
    t.integer  "epcandwicd",               limit: 4
    t.integer  "epmeasr",                  limit: 4
    t.integer  "epmeasrfsc",               limit: 4
    t.integer  "epmeasrcd",                limit: 4
    t.decimal  "epicrp",                                 precision: 6, scale: 2
    t.boolean  "epicrpfed",                limit: 1
    t.boolean  "epicrpcounty",             limit: 1
    t.boolean  "epicrpown",                limit: 1
    t.boolean  "epicrpoth",                limit: 1
    t.integer  "eptotindirc",              limit: 4
    t.integer  "eptotelectc",              limit: 4
    t.boolean  "epcostallrg",              limit: 1
    t.boolean  "epcostallpre",             limit: 1
    t.boolean  "epcostallopp",             limit: 1
    t.boolean  "epcostalloth",             limit: 1
    t.integer  "eptotbilled",              limit: 4
    t.integer  "eptotcounty",              limit: 4
    t.integer  "eptotsb90c",               limit: 4
    t.integer  "eptotsb90r",               limit: 4
    t.text     "epmandates",               limit: 65535
    t.boolean  "started",                  limit: 1,                             default: false
    t.boolean  "complete",                 limit: 1,                             default: false
    t.string   "current_step",             limit: 255
    t.integer  "county_id",                limit: 4
    t.integer  "election_year_profile_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "epppbalpapar",             limit: 1
    t.boolean  "epppbalpapbu",             limit: 1
    t.boolean  "epppbalpapot",             limit: 1
    t.integer  "epvbmretpp",               limit: 4
    t.integer  "epvbmirevl",               limit: 4
    t.integer  "epvbmrrevl",               limit: 4
    t.integer  "epprovcwbt",               limit: 4
    t.integer  "epprovcwp",                limit: 4
    t.integer  "epprovncvnr",              limit: 4
    t.integer  "epprovncbrva",             limit: 4
    t.integer  "epprovncoth",              limit: 4
    t.integer  "epprovvbm",                limit: 4
    t.integer  "epprovnor",                limit: 4
    t.integer  "epprovhava",               limit: 4
    t.integer  "epprovunivs",              limit: 4
    t.integer  "epprovoutr",               limit: 4
    t.integer  "epcanvdrere",              limit: 4
    t.integer  "eplangvra",                limit: 4
    t.integer  "eplangcaec",               limit: 4
    t.text     "eplangloc",                limit: 65535
    t.integer  "eptotcandca",              limit: 4
    t.integer  "eptotvolunth",             limit: 4
    t.integer  "eplangvrao",               limit: 4
    t.integer  "eplangcaeco",              limit: 4
    t.boolean  "epems_na",                 limit: 1,                             default: false, null: false
    t.boolean  "eppphwscan_na",            limit: 1,                             default: false, null: false
    t.boolean  "eppphwdre_na",             limit: 1,                             default: false, null: false
    t.boolean  "eppphwmarkd_na",           limit: 1,                             default: false, null: false
    t.boolean  "eppphwpollbk_na",          limit: 1,                             default: false, null: false
    t.boolean  "eppphwoth_na",             limit: 1,                             default: false, null: false
    t.boolean  "epetallysys_na",           limit: 1,                             default: false, null: false
    t.boolean  "epppbalpap_na",            limit: 1,                             default: false, null: false
    t.boolean  "epppbalaccsd_na",          limit: 1,                             default: false, null: false
    t.boolean  "eprv_na",                  limit: 1,                             default: false, null: false
    t.boolean  "eppploc_na",               limit: 1,                             default: false, null: false
    t.boolean  "epprecwpp_na",             limit: 1,                             default: false, null: false
    t.boolean  "epprecvbm_na",             limit: 1,                             default: false, null: false
    t.boolean  "epbaltype_na",             limit: 1,                             default: false, null: false
    t.boolean  "epbalpage_na",             limit: 1,                             default: false, null: false
    t.boolean  "epbalsampvip_na",          limit: 1,                             default: false, null: false
    t.boolean  "epvipinsrt_na",            limit: 1,                             default: false, null: false
    t.boolean  "epbalofficl_na",           limit: 1,                             default: false, null: false
    t.boolean  "epvbmmail_na",             limit: 1,                             default: false, null: false
    t.boolean  "epvbmmailprm_na",          limit: 1,                             default: false, null: false
    t.boolean  "epvbmmailmbp_na",          limit: 1,                             default: false, null: false
    t.boolean  "epvbmmailuo_na",           limit: 1,                             default: false, null: false
    t.boolean  "epvbmotc_na",              limit: 1,                             default: false, null: false
    t.boolean  "epvbmret_na",              limit: 1,                             default: false, null: false
    t.boolean  "epvbmretprm_na",           limit: 1,                             default: false, null: false
    t.boolean  "epvbmretmbp_na",           limit: 1,                             default: false, null: false
    t.boolean  "epvbmretuo_na",            limit: 1,                             default: false, null: false
    t.boolean  "epvbmundel_na",            limit: 1,                             default: false, null: false
    t.boolean  "epvbmchal_na",             limit: 1,                             default: false, null: false
    t.boolean  "epvbmprovc_na",            limit: 1,                             default: false, null: false
    t.boolean  "epvbmprovnc_na",           limit: 1,                             default: false, null: false
    t.boolean  "epcand_na",                limit: 1,                             default: false, null: false
    t.boolean  "epcandfsc_na",             limit: 1,                             default: false, null: false
    t.boolean  "epcandcd_na",              limit: 1,                             default: false, null: false
    t.boolean  "epcandwi_na",              limit: 1,                             default: false, null: false
    t.boolean  "epcandwifsc_na",           limit: 1,                             default: false, null: false
    t.boolean  "epcandwicd_na",            limit: 1,                             default: false, null: false
    t.boolean  "epmeasr_na",               limit: 1,                             default: false, null: false
    t.boolean  "epmeasrfsc_na",            limit: 1,                             default: false, null: false
    t.boolean  "epmeasrcd_na",             limit: 1,                             default: false, null: false
    t.boolean  "epicrp_na",                limit: 1,                             default: false, null: false
    t.boolean  "epicrpfed_na",             limit: 1,                             default: false, null: false
    t.boolean  "epicrpcounty_na",          limit: 1,                             default: false, null: false
    t.boolean  "epicrpown_na",             limit: 1,                             default: false, null: false
    t.boolean  "epicrpoth_na",             limit: 1,                             default: false, null: false
    t.boolean  "eptotindirc_na",           limit: 1,                             default: false, null: false
    t.boolean  "eptotelectc_na",           limit: 1,                             default: false, null: false
    t.boolean  "epcostallrg_na",           limit: 1,                             default: false, null: false
    t.boolean  "epcostallpre_na",          limit: 1,                             default: false, null: false
    t.boolean  "epcostallopp_na",          limit: 1,                             default: false, null: false
    t.boolean  "epcostalloth_na",          limit: 1,                             default: false, null: false
    t.boolean  "eptotbilled_na",           limit: 1,                             default: false, null: false
    t.boolean  "eptotcounty_na",           limit: 1,                             default: false, null: false
    t.boolean  "eptotsb90c_na",            limit: 1,                             default: false, null: false
    t.boolean  "eptotsb90r_na",            limit: 1,                             default: false, null: false
    t.boolean  "epmandates_na",            limit: 1,                             default: false, null: false
    t.boolean  "epppbalpapar_na",          limit: 1,                             default: false, null: false
    t.boolean  "epppbalpapbu_na",          limit: 1,                             default: false, null: false
    t.boolean  "epppbalpapot_na",          limit: 1,                             default: false, null: false
    t.boolean  "epvbmretpp_na",            limit: 1,                             default: false, null: false
    t.boolean  "epvbmirevl_na",            limit: 1,                             default: false, null: false
    t.boolean  "epvbmrrevl_na",            limit: 1,                             default: false, null: false
    t.boolean  "epprovcwbt_na",            limit: 1,                             default: false, null: false
    t.boolean  "epprovcwp_na",             limit: 1,                             default: false, null: false
    t.boolean  "epprovncvnr_na",           limit: 1,                             default: false, null: false
    t.boolean  "epprovncbrva_na",          limit: 1,                             default: false, null: false
    t.boolean  "epprovncoth_na",           limit: 1,                             default: false, null: false
    t.boolean  "epprovvbm_na",             limit: 1,                             default: false, null: false
    t.boolean  "epprovnor_na",             limit: 1,                             default: false, null: false
    t.boolean  "epprovhava_na",            limit: 1,                             default: false, null: false
    t.boolean  "epprovunivs_na",           limit: 1,                             default: false, null: false
    t.boolean  "epprovoutr_na",            limit: 1,                             default: false, null: false
    t.boolean  "epcanvdrere_na",           limit: 1,                             default: false, null: false
    t.boolean  "eplangvra_na",             limit: 1,                             default: false, null: false
    t.boolean  "eplangcaec_na",            limit: 1,                             default: false, null: false
    t.boolean  "eplangloc_na",             limit: 1,                             default: false, null: false
    t.boolean  "eptotcandca_na",           limit: 1,                             default: false, null: false
    t.boolean  "eptotvolunth_na",          limit: 1,                             default: false, null: false
    t.boolean  "eplangvrao_na",            limit: 1,                             default: false, null: false
    t.boolean  "eplangcaeco_na",           limit: 1,                             default: false, null: false
    t.integer  "election_year_id",         limit: 4
  end

  add_index "election_profiles", ["current_step"], name: "index_election_profiles_on_current_step", using: :btree
  add_index "election_profiles", ["election_year_id"], name: "index_election_profiles_on_election_year_id", using: :btree

  create_table "election_technologies", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "election_year_profiles", force: :cascade do |t|
    t.string   "year",          limit: 255
    t.date     "election_dt"
    t.integer  "year_dt",       limit: 4
    t.string   "election_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edate_full",    limit: 255
  end

  create_table "election_years", force: :cascade do |t|
    t.string   "year",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "election_dt"
    t.integer  "year_dt",       limit: 4
    t.string   "election_type", limit: 255
    t.string   "edate_full",    limit: 255
  end

  create_table "faqs", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.string   "answer",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "filter_costs", force: :cascade do |t|
    t.text     "fieldlist",  limit: 65535
    t.string   "filtertype", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.integer "question_id", limit: 4,   null: false
  end

  create_table "postages", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "sspossbal",        limit: 4
    t.integer  "ssposuo",          limit: 4
    t.integer  "ssposvbmo",        limit: 4
    t.integer  "ssposvbmi",        limit: 4
    t.integer  "ssposvbmoth",      limit: 4
    t.integer  "ssposoth",         limit: 4
    t.text     "ssposcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssposaddsepm",     limit: 4
    t.boolean  "sspossbal_na",     limit: 1,     default: false, null: false
    t.boolean  "ssposuo_na",       limit: 1,     default: false, null: false
    t.boolean  "ssposvbmo_na",     limit: 1,     default: false, null: false
    t.boolean  "ssposvbmi_na",     limit: 1,     default: false, null: false
    t.boolean  "ssposvbmoth_na",   limit: 1,     default: false, null: false
    t.boolean  "ssposoth_na",      limit: 1,     default: false, null: false
    t.boolean  "ssposaddsepm_na",  limit: 1,     default: false, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "field",              limit: 255
    t.string   "name",               limit: 255
    t.string   "label",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "table_name",         limit: 255
    t.string   "cost_type",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question_type",      limit: 255
    t.integer  "validation_type_id", limit: 4
    t.integer  "subsection_id",      limit: 4
    t.boolean  "sum_able",           limit: 1,     default: false, null: false
    t.boolean  "na_able",            limit: 1,     default: false, null: false
    t.string   "data_type",          limit: 255
    t.string   "na_field",           limit: 255
    t.string   "survey_id",          limit: 20
  end

  add_index "questions", ["subsection_id"], name: "fk_rails_5c3afb9e86", using: :btree
  add_index "questions", ["validation_type_id"], name: "fk_rails_2138119a33", using: :btree

  create_table "response_values", force: :cascade do |t|
    t.integer  "survey_response_id", limit: 4
    t.integer  "question_id",        limit: 4
    t.string   "data_type",          limit: 255
    t.integer  "integer_value",      limit: 4
    t.decimal  "decimal_value",                    precision: 10
    t.string   "string_value",       limit: 255
    t.text     "text_value",         limit: 65535
    t.boolean  "na_value",           limit: 1,                    default: false, null: false
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.boolean  "boolean_value",      limit: 1
  end

  add_index "response_values", ["question_id"], name: "index_response_values_on_question_id", using: :btree
  add_index "response_values", ["survey_response_id", "question_id"], name: "index_on_survey_response_values_survey_response_questions", unique: true, using: :btree
  add_index "response_values", ["survey_response_id"], name: "index_response_values_on_survey_response_id", using: :btree

  create_table "role_assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salbals", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salbaldesign",     limit: 4
    t.integer  "salbaltrans",      limit: 4
    t.integer  "salbalorder",      limit: 4
    t.integer  "salbalmail",       limit: 4
    t.integer  "salbalother",      limit: 4
    t.integer  "salbalpsrp",       limit: 4
    t.integer  "salbalpsop",       limit: 4
    t.integer  "salbaltsrp",       limit: 4
    t.integer  "salbaltsop",       limit: 4
    t.integer  "salbalbeps",       limit: 4
    t.integer  "salbalbepsp",      limit: 4
    t.integer  "salbalbets",       limit: 4
    t.integer  "salbalbetsp",      limit: 4
    t.integer  "salbalhrsps",      limit: 4
    t.integer  "salbalhrsts",      limit: 4
    t.text     "salbalcomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salbaldesign_na",  limit: 1,     default: false, null: false
    t.boolean  "salbaltrans_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalorder_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalmail_na",    limit: 1,     default: false, null: false
    t.boolean  "salbalother_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalpsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salbalpsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salbaltsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salbaltsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salbalbeps_na",    limit: 1,     default: false, null: false
    t.boolean  "salbalbepsp_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalbets_na",    limit: 1,     default: false, null: false
    t.boolean  "salbalbetsp_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalhrsps_na",   limit: 1,     default: false, null: false
    t.boolean  "salbalhrsts_na",   limit: 1,     default: false, null: false
  end

  create_table "salbcs", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salbcsec",         limit: 4
    t.integer  "sabcoth",          limit: 4
    t.integer  "salbcpsrp",        limit: 4
    t.integer  "salbcpsop",        limit: 4
    t.integer  "salbctsrp",        limit: 4
    t.integer  "salbctsop",        limit: 4
    t.integer  "salbcbeps",        limit: 4
    t.integer  "salbcbets",        limit: 4
    t.integer  "salbchrsps",       limit: 4
    t.integer  "salbchrsts",       limit: 4
    t.text     "salbccomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salbcnvbmp",       limit: 4
    t.integer  "salbcvbm",         limit: 4
    t.integer  "salbcprov",        limit: 4
    t.integer  "salbcprocpb",      limit: 4
    t.integer  "salbccanvdb",      limit: 4
    t.integer  "salbccanvone",     limit: 4
    t.integer  "salbccanvdre",     limit: 4
    t.integer  "salbccanvpa",      limit: 4
    t.integer  "salbccanvsa",      limit: 4
    t.integer  "salbccanvva",      limit: 4
    t.integer  "salbccanvoth",     limit: 4
    t.boolean  "salbcsec_na",      limit: 1,     default: false, null: false
    t.boolean  "sabcoth_na",       limit: 1,     default: false, null: false
    t.boolean  "salbcpsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salbcpsop_na",     limit: 1,     default: false, null: false
    t.boolean  "salbctsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salbctsop_na",     limit: 1,     default: false, null: false
    t.boolean  "salbcbeps_na",     limit: 1,     default: false, null: false
    t.boolean  "salbcbets_na",     limit: 1,     default: false, null: false
    t.boolean  "salbchrsps_na",    limit: 1,     default: false, null: false
    t.boolean  "salbchrsts_na",    limit: 1,     default: false, null: false
    t.boolean  "salbcnvbmp_na",    limit: 1,     default: false, null: false
    t.boolean  "salbcvbm_na",      limit: 1,     default: false, null: false
    t.boolean  "salbcprov_na",     limit: 1,     default: false, null: false
    t.boolean  "salbcprocpb_na",   limit: 1,     default: false, null: false
    t.boolean  "salbccanvdb_na",   limit: 1,     default: false, null: false
    t.boolean  "salbccanvone_na",  limit: 1,     default: false, null: false
    t.boolean  "salbccanvdre_na",  limit: 1,     default: false, null: false
    t.boolean  "salbccanvpa_na",   limit: 1,     default: false, null: false
    t.boolean  "salbccanvsa_na",   limit: 1,     default: false, null: false
    t.boolean  "salbccanvva_na",   limit: 1,     default: false, null: false
    t.boolean  "salbccanvoth_na",  limit: 1,     default: false, null: false
  end

  create_table "salcans", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salcanprep",       limit: 4
    t.integer  "salcanproc",       limit: 4
    t.integer  "slacanoth",        limit: 4
    t.integer  "salcanpsrp",       limit: 4
    t.integer  "salcanpsop",       limit: 4
    t.integer  "salcantsrp",       limit: 4
    t.integer  "salcantsop",       limit: 4
    t.integer  "salcanbeps",       limit: 4
    t.integer  "salcanbets",       limit: 4
    t.integer  "salcanhrsps",      limit: 4
    t.integer  "salcanhrsts",      limit: 4
    t.text     "salcancomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salcanprep_na",    limit: 1,     default: false, null: false
    t.boolean  "salcanproc_na",    limit: 1,     default: false, null: false
    t.boolean  "slacanoth_na",     limit: 1,     default: false, null: false
    t.boolean  "salcanpsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salcanpsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salcantsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salcantsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salcanbeps_na",    limit: 1,     default: false, null: false
    t.boolean  "salcanbets_na",    limit: 1,     default: false, null: false
    t.boolean  "salcanhrsps_na",   limit: 1,     default: false, null: false
    t.boolean  "salcanhrsts_na",   limit: 1,     default: false, null: false
  end

  create_table "saldojos", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "saldojomc",        limit: 4
    t.integer  "saldojopsrp",      limit: 4
    t.integer  "saldojopsop",      limit: 4
    t.integer  "saldojotsrp",      limit: 4
    t.integer  "saldojotsop",      limit: 4
    t.integer  "saldojobeps",      limit: 4
    t.integer  "saldojobets",      limit: 4
    t.integer  "saldojohrsps",     limit: 4
    t.integer  "saldojohrsts",     limit: 4
    t.text     "saldojocomment",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "saldojomc_na",     limit: 1,     default: false, null: false
    t.boolean  "saldojopsrp_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojopsop_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojotsrp_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojotsop_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojobeps_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojobets_na",   limit: 1,     default: false, null: false
    t.boolean  "saldojohrsps_na",  limit: 1,     default: false, null: false
    t.boolean  "saldojohrsts_na",  limit: 1,     default: false, null: false
  end

  create_table "salmeds", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salmedprep",       limit: 4
    t.integer  "salmedhandl",      limit: 4
    t.integer  "salmedpsrp",       limit: 4
    t.integer  "salmedpsop",       limit: 4
    t.integer  "salmedtsrp",       limit: 4
    t.integer  "salmedtsop",       limit: 4
    t.integer  "salmedbe",         limit: 4
    t.integer  "salmedbep",        limit: 4
    t.integer  "salmedbeps",       limit: 4
    t.integer  "salmedbets",       limit: 4
    t.integer  "salmedhrsps",      limit: 4
    t.integer  "salmedhrsts",      limit: 4
    t.text     "salmedcomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salmedcampm",      limit: 4
    t.boolean  "salmedprep_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedhandl_na",   limit: 1,     default: false, null: false
    t.boolean  "salmedpsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedpsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedtsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedtsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedbe_na",      limit: 1,     default: false, null: false
    t.boolean  "salmedbep_na",     limit: 1,     default: false, null: false
    t.boolean  "salmedbeps_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedbets_na",    limit: 1,     default: false, null: false
    t.boolean  "salmedhrsps_na",   limit: 1,     default: false, null: false
    t.boolean  "salmedhrsts_na",   limit: 1,     default: false, null: false
    t.boolean  "salmedcampm_na",   limit: 1,     default: false, null: false
  end

  create_table "saloths", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salothvoed",       limit: 4
    t.integer  "salothvore",       limit: 4
    t.integer  "salothelcal",      limit: 4
    t.integer  "salothstind",      limit: 4
    t.integer  "salothvoros",      limit: 4
    t.integer  "salother",         limit: 4
    t.integer  "salothpsrp",       limit: 4
    t.integer  "salothpsop",       limit: 4
    t.integer  "salothtsrp",       limit: 4
    t.integer  "salothtsop",       limit: 4
    t.integer  "salothbeps",       limit: 4
    t.integer  "salothbets",       limit: 4
    t.integer  "salothhrsps",      limit: 4
    t.integer  "salothhrsts",      limit: 4
    t.text     "salothcomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salothvoedm",      limit: 4
    t.integer  "salothvorepr",     limit: 4
    t.integer  "salothrevm",       limit: 4
    t.integer  "salothhotm",       limit: 4
    t.integer  "salothdatam",      limit: 4
    t.boolean  "salothvoed_na",    limit: 1,     default: false, null: false
    t.boolean  "salothvore_na",    limit: 1,     default: false, null: false
    t.boolean  "salothelcal_na",   limit: 1,     default: false, null: false
    t.boolean  "salothstind_na",   limit: 1,     default: false, null: false
    t.boolean  "salothvoros_na",   limit: 1,     default: false, null: false
    t.boolean  "salother_na",      limit: 1,     default: false, null: false
    t.boolean  "salothpsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salothpsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salothtsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salothtsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salothbeps_na",    limit: 1,     default: false, null: false
    t.boolean  "salothbets_na",    limit: 1,     default: false, null: false
    t.boolean  "salothhrsps_na",   limit: 1,     default: false, null: false
    t.boolean  "salothhrsts_na",   limit: 1,     default: false, null: false
    t.boolean  "salothvoedm_na",   limit: 1,     default: false, null: false
    t.boolean  "salothvorepr_na",  limit: 1,     default: false, null: false
    t.boolean  "salothrevm_na",    limit: 1,     default: false, null: false
    t.boolean  "salothhotm_na",    limit: 1,     default: false, null: false
    t.boolean  "salothdatam_na",   limit: 1,     default: false, null: false
  end

  create_table "salpps", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salppsurvey",      limit: 4
    t.integer  "salpporder",       limit: 4
    t.integer  "salppve",          limit: 4
    t.integer  "salppdelve",       limit: 4
    t.integer  "salpppay",         limit: 4
    t.integer  "salpppubnot",      limit: 4
    t.integer  "salppoth",         limit: 4
    t.integer  "salpppsrp",        limit: 4
    t.integer  "salpppsop",        limit: 4
    t.integer  "salpptsrp",        limit: 4
    t.integer  "salpptsop",        limit: 4
    t.integer  "salppbeps",        limit: 4
    t.integer  "salppbets",        limit: 4
    t.integer  "salpphrsps",       limit: 4
    t.integer  "salpphrsts",       limit: 4
    t.text     "salppcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salppemattr",      limit: 4
    t.boolean  "salppsurvey_na",   limit: 1,     default: false, null: false
    t.boolean  "salpporder_na",    limit: 1,     default: false, null: false
    t.boolean  "salppve_na",       limit: 1,     default: false, null: false
    t.boolean  "salppdelve_na",    limit: 1,     default: false, null: false
    t.boolean  "salpppay_na",      limit: 1,     default: false, null: false
    t.boolean  "salpppubnot_na",   limit: 1,     default: false, null: false
    t.boolean  "salppoth_na",      limit: 1,     default: false, null: false
    t.boolean  "salpppsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salpppsop_na",     limit: 1,     default: false, null: false
    t.boolean  "salpptsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salpptsop_na",     limit: 1,     default: false, null: false
    t.boolean  "salppbeps_na",     limit: 1,     default: false, null: false
    t.boolean  "salppbets_na",     limit: 1,     default: false, null: false
    t.boolean  "salpphrsps_na",    limit: 1,     default: false, null: false
    t.boolean  "salpphrsts_na",    limit: 1,     default: false, null: false
    t.boolean  "salppemattr_na",   limit: 1,     default: false, null: false
  end

  create_table "salpws", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salpwrec",         limit: 4
    t.integer  "salpwdvtrain",     limit: 4
    t.integer  "salpwtrain",       limit: 4
    t.integer  "salpwpay",         limit: 4
    t.integer  "salpwoth",         limit: 4
    t.integer  "salpwpsrp",        limit: 4
    t.integer  "salpwpsop",        limit: 4
    t.integer  "salpwtsrp",        limit: 4
    t.integer  "salpwrtsop",       limit: 4
    t.integer  "salpwbeps",        limit: 4
    t.integer  "salpwbets",        limit: 4
    t.integer  "salpwhrsps",       limit: 4
    t.integer  "salpwhrsts",       limit: 4
    t.text     "salpwhcomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salpwrecm",        limit: 4
    t.boolean  "salpwrec_na",      limit: 1,     default: false, null: false
    t.boolean  "salpwdvtrain_na",  limit: 1,     default: false, null: false
    t.boolean  "salpwtrain_na",    limit: 1,     default: false, null: false
    t.boolean  "salpwpay_na",      limit: 1,     default: false, null: false
    t.boolean  "salpwoth_na",      limit: 1,     default: false, null: false
    t.boolean  "salpwpsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salpwpsop_na",     limit: 1,     default: false, null: false
    t.boolean  "salpwtsrp_na",     limit: 1,     default: false, null: false
    t.boolean  "salpwrtsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salpwbeps_na",     limit: 1,     default: false, null: false
    t.boolean  "salpwbets_na",     limit: 1,     default: false, null: false
    t.boolean  "salpwhrsps_na",    limit: 1,     default: false, null: false
    t.boolean  "salpwhrsts_na",    limit: 1,     default: false, null: false
    t.boolean  "salpwrecm_na",     limit: 1,     default: false, null: false
  end

  create_table "salvbms", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "salvbmoutr",       limit: 4
    t.integer  "salvbmappro",      limit: 4
    t.integer  "salvbmuoapp",      limit: 4
    t.integer  "salvbmusps",       limit: 4
    t.integer  "salvbmproces",     limit: 4
    t.integer  "salvbmoth",        limit: 4
    t.integer  "salvbmpsrp",       limit: 4
    t.integer  "salvbmpsop",       limit: 4
    t.integer  "salvbmtsrp",       limit: 4
    t.integer  "salvbmtsop",       limit: 4
    t.integer  "salvbmbeps",       limit: 4
    t.integer  "salvbmbets",       limit: 4
    t.integer  "salvbmhrsps",      limit: 4
    t.integer  "salvbmhrsts",      limit: 4
    t.text     "salvbmcomment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "salvbmoutr_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmappro_na",   limit: 1,     default: false, null: false
    t.boolean  "salvbmuoapp_na",   limit: 1,     default: false, null: false
    t.boolean  "salvbmusps_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmproces_na",  limit: 1,     default: false, null: false
    t.boolean  "salvbmoth_na",     limit: 1,     default: false, null: false
    t.boolean  "salvbmpsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmpsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmtsrp_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmtsop_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmbeps_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmbets_na",    limit: 1,     default: false, null: false
    t.boolean  "salvbmhrsps_na",   limit: 1,     default: false, null: false
    t.boolean  "salvbmhrsts_na",   limit: 1,     default: false, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssbals", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "ssballayout",      limit: 4
    t.integer  "ssbaltransl",      limit: 4
    t.integer  "ssbalpri",         limit: 4
    t.integer  "ssbalprisb",       limit: 4
    t.integer  "ssbalprisben",     limit: 4
    t.integer  "ssbalprisbch",     limit: 4
    t.integer  "ssbalprisbko",     limit: 4
    t.integer  "ssbalprisbsp",     limit: 4
    t.integer  "ssbalrpisbvi",     limit: 4
    t.integer  "ssbalprisbja",     limit: 4
    t.integer  "ssbalprisbta",     limit: 4
    t.integer  "ssbalprisbkh",     limit: 4
    t.integer  "ssbalprisbhi",     limit: 4
    t.integer  "ssbalprisbth",     limit: 4
    t.integer  "ssbalprisbfi",     limit: 4
    t.integer  "ssbalpriob",       limit: 4
    t.integer  "ssbalprioben",     limit: 4
    t.integer  "ssbalpriobch",     limit: 4
    t.integer  "ssbalpriobko",     limit: 4
    t.integer  "ssbalpriobsp",     limit: 4
    t.integer  "ssbalpriobvi",     limit: 4
    t.integer  "ssbalpriobja",     limit: 4
    t.integer  "ssbalpriobta",     limit: 4
    t.integer  "ssbalpriobkh",     limit: 4
    t.integer  "ssbalpriobhi",     limit: 4
    t.integer  "ssbalpriobth",     limit: 4
    t.integer  "ssbalpriobfi",     limit: 4
    t.integer  "ssbalprivbm",      limit: 4
    t.integer  "ssbalpriuo",       limit: 4
    t.integer  "ssbalpriprot",     limit: 4
    t.integer  "ssbalpriship",     limit: 4
    t.integer  "ssbalprioth",      limit: 4
    t.text     "ssbalcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssbalprisbmc",     limit: 4
    t.integer  "ssbalpriobmc",     limit: 4
    t.decimal  "ssbalpriprou",                   precision: 3, scale: 2
    t.integer  "ssbalprisb1ml",    limit: 4
    t.integer  "ssbalprisb2ml",    limit: 4
    t.integer  "ssbalprisb3ml",    limit: 4
    t.integer  "ssbalprisb1mc",    limit: 4
    t.integer  "ssbalprisb2mc",    limit: 4
    t.integer  "ssbalprisb3mc",    limit: 4
    t.integer  "ssbalpriob1ml",    limit: 4
    t.integer  "ssbalpriob2ml",    limit: 4
    t.integer  "ssbalpriob3ml",    limit: 4
    t.integer  "ssbalpriob1mc",    limit: 4
    t.integer  "ssbalpriob2mc",    limit: 4
    t.integer  "ssbalpriob3mc",    limit: 4
    t.boolean  "ssballayout_na",   limit: 1,                             default: false, null: false
    t.boolean  "ssbaltransl_na",   limit: 1,                             default: false, null: false
    t.boolean  "ssbalpri_na",      limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb_na",    limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisben_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbch_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbko_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbsp_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalrpisbvi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbja_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbta_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbkh_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbhi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbth_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisbfi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob_na",    limit: 1,                             default: false, null: false
    t.boolean  "ssbalprioben_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobch_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobko_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobsp_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobvi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobja_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobta_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobkh_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobhi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobth_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriobfi_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprivbm_na",   limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriuo_na",    limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriprot_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriship_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprioth_na",   limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriprou_na",  limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb1ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb2ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb3ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob1ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob2ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob3ml_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb1mc_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb2mc_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalprisb3mc_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob1mc_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob2mc_na", limit: 1,                             default: false, null: false
    t.boolean  "ssbalpriob3mc_na", limit: 1,                             default: false, null: false
  end

  create_table "ssbcs", force: :cascade do |t|
    t.integer  "ssbcprocvbh",      limit: 4
    t.integer  "ssbcprocpbh",      limit: 4
    t.integer  "ssbcprocs",        limit: 4
    t.integer  "ssbcbcounth",      limit: 4
    t.integer  "ssbcbcounts",      limit: 4
    t.integer  "ssbccanvh",        limit: 4
    t.integer  "ssbccanvs",        limit: 4
    t.integer  "ssbcpcsec",        limit: 4
    t.text     "ssbccomment",      limit: 65535
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ssbcprocvbh_na",   limit: 1,     default: false, null: false
    t.boolean  "ssbcprocpbh_na",   limit: 1,     default: false, null: false
    t.boolean  "ssbcprocs_na",     limit: 1,     default: false, null: false
    t.boolean  "ssbcbcounth_na",   limit: 1,     default: false, null: false
    t.boolean  "ssbcbcounts_na",   limit: 1,     default: false, null: false
    t.boolean  "ssbccanvh_na",     limit: 1,     default: false, null: false
    t.boolean  "ssbccanvs_na",     limit: 1,     default: false, null: false
    t.boolean  "ssbcpcsec_na",     limit: 1,     default: false, null: false
  end

  create_table "sscans", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "sscanprint",       limit: 4
    t.text     "sscancomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sscanprint_na",    limit: 1,     default: false, null: false
  end

  create_table "ssmeds", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "ssmedprint",       limit: 4
    t.text     "ssmedcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssmedcampm",       limit: 4
    t.boolean  "ssmedprint_na",    limit: 1,     default: false, null: false
    t.boolean  "ssmedcampm_na",    limit: 1,     default: false, null: false
  end

  create_table "ssoths", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "ssothoutrea",      limit: 4
    t.integer  "ssothwareh",       limit: 4
    t.integer  "ssothelcom",       limit: 4
    t.integer  "ssothphbank",      limit: 4
    t.integer  "ssothwebsite",     limit: 4
    t.integer  "ssothcpst",        limit: 4
    t.integer  "ssothoth",         limit: 4
    t.text     "ssothcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssothoutream",     limit: 4
    t.integer  "ssothrevm",        limit: 4
    t.integer  "ssothhotm",        limit: 4
    t.integer  "ssothdatam",       limit: 4
    t.integer  "ssothothm",        limit: 4
    t.boolean  "ssothoutrea_na",   limit: 1,     default: false, null: false
    t.boolean  "ssothwareh_na",    limit: 1,     default: false, null: false
    t.boolean  "ssothelcom_na",    limit: 1,     default: false, null: false
    t.boolean  "ssothphbank_na",   limit: 1,     default: false, null: false
    t.boolean  "ssothwebsite_na",  limit: 1,     default: false, null: false
    t.boolean  "ssothcpst_na",     limit: 1,     default: false, null: false
    t.boolean  "ssothoth_na",      limit: 1,     default: false, null: false
    t.boolean  "ssothoutream_na",  limit: 1,     default: false, null: false
    t.boolean  "ssothrevm_na",     limit: 1,     default: false, null: false
    t.boolean  "ssothhotm_na",     limit: 1,     default: false, null: false
    t.boolean  "ssothdatam_na",    limit: 1,     default: false, null: false
    t.boolean  "ssothothm_na",     limit: 1,     default: false, null: false
  end

  create_table "sspps", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "ssppsurvey",       limit: 4
    t.integer  "sspprent",         limit: 4
    t.integer  "ssppmod",          limit: 4
    t.integer  "ssppdelive",       limit: 4
    t.integer  "ssppsup",          limit: 4
    t.integer  "ssppsec",          limit: 4
    t.integer  "ssppoth",          limit: 4
    t.text     "ssppcomment",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ssppsupm",         limit: 4
    t.boolean  "ssppsurvey_na",    limit: 1,     default: false, null: false
    t.boolean  "sspprent_na",      limit: 1,     default: false, null: false
    t.boolean  "ssppmod_na",       limit: 1,     default: false, null: false
    t.boolean  "ssppdelive_na",    limit: 1,     default: false, null: false
    t.boolean  "ssppsup_na",       limit: 1,     default: false, null: false
    t.boolean  "ssppsec_na",       limit: 1,     default: false, null: false
    t.boolean  "ssppoth_na",       limit: 1,     default: false, null: false
    t.boolean  "ssppsupm_na",      limit: 1,     default: false, null: false
  end

  create_table "sspws", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "sspwrec",          limit: 4
    t.integer  "sspwtrain",        limit: 4
    t.integer  "sspwcomp",         limit: 4
    t.integer  "sspwoth",          limit: 4
    t.text     "sspwcomment",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sspwrecm",         limit: 4
    t.integer  "sspwcompm",        limit: 4
    t.boolean  "sspwrec_na",       limit: 1,     default: false, null: false
    t.boolean  "sspwtrain_na",     limit: 1,     default: false, null: false
    t.boolean  "sspwcomp_na",      limit: 1,     default: false, null: false
    t.boolean  "sspwoth_na",       limit: 1,     default: false, null: false
    t.boolean  "sspwrecm_na",      limit: 1,     default: false, null: false
    t.boolean  "sspwcompm_na",     limit: 1,     default: false, null: false
  end

  create_table "ssvehs", force: :cascade do |t|
    t.integer  "election_year_id", limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "ssvehrent",        limit: 4
    t.integer  "ssvehcount",       limit: 4
    t.integer  "ssvehfuel",        limit: 4
    t.integer  "ssvehins",         limit: 4
    t.text     "ssvehcomment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ssvehrent_na",     limit: 1,     default: false, null: false
    t.boolean  "ssvehcount_na",    limit: 1,     default: false, null: false
    t.boolean  "ssvehfuel_na",     limit: 1,     default: false, null: false
    t.boolean  "ssvehins_na",      limit: 1,     default: false, null: false
  end

  create_table "subsections", force: :cascade do |t|
    t.string  "title",     limit: 255
    t.boolean "totalable", limit: 1
  end

  create_table "survey_responses", force: :cascade do |t|
    t.integer  "response_id",   limit: 4,  null: false
    t.integer  "election_id",   limit: 4,  null: false
    t.string   "response_type", limit: 20, null: false
    t.integer  "county_id",     limit: 4,  null: false
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "survey_responses", ["county_id", "election_id", "response_type"], name: "index_survey_responses_on_county_election_and_survey", unique: true, using: :btree
  add_index "survey_responses", ["election_id"], name: "index_survey_responses_on_election_id", using: :btree

  create_table "survey_subsections", force: :cascade do |t|
    t.integer "subsection_id", limit: 4
    t.string  "survey_id",     limit: 20
  end

  add_index "survey_subsections", ["subsection_id"], name: "index_survey_subsections_on_subsection_id", using: :btree

  create_table "survey_totals_subsections", id: false, force: :cascade do |t|
    t.integer "subsection_id", limit: 4,  null: false
    t.string  "survey_id",     limit: 20
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "category",   limit: 255
    t.string   "table_name", limit: 255
    t.string   "subject",    limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "tech_voting_machines", force: :cascade do |t|
    t.string   "voting_equip_type",       limit: 255
    t.date     "purchase_dt"
    t.string   "equip_make",              limit: 255
    t.integer  "purchase_price",          limit: 4
    t.integer  "quantity",                limit: 4
    t.string   "offset_funds_src",        limit: 255
    t.integer  "offset_amount",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "county_id",               limit: 4
    t.boolean  "purchase_price_services", limit: 1
  end

  create_table "tech_voting_softwares", force: :cascade do |t|
    t.string   "software_item",           limit: 255
    t.date     "purchase_dt"
    t.integer  "purchase_price_hardware", limit: 4
    t.integer  "purchase_price_software", limit: 4
    t.integer  "mat_charges",             limit: 4
    t.integer  "labor_costs",             limit: 4
    t.integer  "county_id",               limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                limit: 255
    t.string   "email",                   limit: 255
    t.string   "encrypted_password",      limit: 255
    t.string   "salt",                    limit: 255
    t.integer  "county_id",               limit: 4
    t.string   "security_answer",         limit: 255
    t.string   "security_question",       limit: 255
    t.string   "access_code",             limit: 255
    t.boolean  "reset_password",          limit: 1,   default: false
    t.string   "status",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token",    limit: 255
    t.datetime "password_reset_sent_at"
    t.datetime "announcements_viewed_at"
  end

  add_index "users", ["county_id"], name: "index_users_on_county_id", using: :btree

  create_table "validation_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_foreign_key "election_profiles", "election_years"
  add_foreign_key "questions", "subsections"
  add_foreign_key "questions", "validation_types"
  add_foreign_key "response_values", "questions", on_delete: :cascade
  add_foreign_key "response_values", "survey_responses", on_delete: :cascade
  add_foreign_key "survey_subsections", "subsections"
end
