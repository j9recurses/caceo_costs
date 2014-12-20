class AddNaColumnsToRemainingTables < ActiveRecord::Migration
  def change
    change_table(:saldojos) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :saldojomc_na, :saldojopsrp_na, :saldojopsop_na, 
        :saldojotsrp_na, :saldojotsop_na, :saldojobeps_na, :saldojobepsp_na, 
        :saldojobets_na, :saldojobetsp_na, :saldojohrsps_na, :saldojohrsts_na,
        default: false, null: false
    end

    change_table(:salmeds) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salmedprep_na, :salmedhandl_na, :salmedpsrp_na, :salmedpsop_na, 
        :salmedtsrp_na, :salmedtsop_na, :salmedbe_na, :salmedbep_na, :salmedbeps_na, 
        :salmedbepsp_na, :salmedbets_na, :salmedbetsp_na, :salmedhrsps_na, :salmedhrsts_na, 
        :salmedcampm_na,
        default: false, null: false
    end

    change_table(:saloths) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salothvoed_na, :salothvore_na, :salothelcal_na, :salothstind_na, 
        :salothvoros_na, :salother_na, :salothpsrp_na, :salothpsop_na, 
        :salothtsrp_na, :salothtsop_na, :salothbeps_na, :salothbepsp_na, 
        :salothbets_na, :salothbetsp_na, :salothhrsps_na, :salothhrsts_na, 
        :salothvoedm_na, :salothvorepr_na, :salothrevm_na, :salothhotm_na, :salothdatam_na,
        default: false, null: false
    end

    change_table(:salpps) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salppsurvey_na, :salpporder_na, :salppve_na, :salppdelve_na, 
        :salpppay_na, :salpppubnot_na, :salppoth_na, :salpppsrp_na, :salpppsop_na, 
        :salpptsrp_na, :salpptsop_na, :salppbeps_na, :salppbepsp_na, :salppbets_na, 
        :salppbetsp_na, :salpphrsps_na, :salpphrsts_na, :salppemattr_na,
        default: false, null: false
    end

    change_table(:salpws) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salpwrec_na, :salpwdvtrain_na, :salpwtrain_na, :salpwpay_na, 
        :salpwoth_na, :salpwpsrp_na, :salpwpsop_na, :salpwtsrp_na, :salpwrtsop_na, 
        :salpwbeps_na, :salpwbepsp_na, :salpwbets_na, :salpwbetsp_na, :salpwhrsps_na, 
        :salpwhrsts_na, :salpwrecm_na,
        default: false, null: false
    end

    change_table(:salvbms) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salvbmoutr_na, :salvbmappro_na, :salvbmuoapp_na, :salvbmusps_na, 
        :salvbmproces_na, :salvbmoth_na, :salvbmpsrp_na, :salvbmpsop_na, :salvbmtsrp_na, 
        :salvbmtsop_na, :salvbmbeps_na, :salvbmbepsp_na, :salvbmbets_na, :salvbmbetsp_na, 
        :salvbmhrsps_na, :salvbmhrsts_na,
        default: false, null: false
    end

    change_table(:ssbals) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssballayout_na, :ssbaltransl_na, :ssbalpri_na, :ssbalprisb_na, :ssbalprisben_na, 
        :ssbalprisbch_na, :ssbalprisbko_na, :ssbalprisbsp_na, :ssbalrpisbvi_na, :ssbalprisbja_na, 
        :ssbalprisbta_na, :ssbalprisbkh_na, :ssbalprisbhi_na, :ssbalprisbth_na, :ssbalprisbfi_na, 
        :ssbalpriob_na, :ssbalprioben_na, :ssbalpriobch_na, :ssbalpriobko_na, :ssbalpriobsp_na, 
        :ssbalpriobvi_na, :ssbalpriobja_na, :ssbalpriobta_na, :ssbalpriobkh_na, :ssbalpriobhi_na, 
        :ssbalpriobth_na, :ssbalpriobfi_na, :ssbalprivbm_na, :ssbalpriuo_na, :ssbalpriprot_na, 
        :ssbalpriship_na, :ssbalprioth_na,
        :ssbalpriprou_na, :ssbalprisb1ml_na, :ssbalprisb2ml_na, :ssbalprisb3ml_na,
        :ssbalpriob1ml_na, :ssbalpriob2ml_na, :ssbalpriob3ml_na, 
        default: false, null: false
    end

    change_table(:ssbcs) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssbcprocvbh_na, :ssbcprocpbh_na, :ssbcprocs_na, :ssbcbcounth_na, :ssbcbcounts_na, 
        :ssbccanvh_na, :ssbccanvs_na, :ssbcpcsec_na,
        default: false, null: false
    end

    change_table(:sscans) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :sscanprint_na,
        default: false, null: false
    end

    change_table(:ssmeds) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssmedprint_na, :ssmedcampm_na,
        default: false, null: false
    end

    change_table(:ssoths) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssothoutrea_na, :ssothwareh_na, :ssothelcom_na, :ssothphbank_na, :ssothwebsite_na, 
      :ssothcpst_na, :ssothoth_na, :ssothoutream_na, :ssothrevm_na, :ssothhotm_na, 
      :ssothdatam_na, :ssothothm_na,
        default: false, null: false
    end

    change_table(:sspps) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssppsurvey_na, :sspprent_na, :ssppmod_na, :ssppdelive_na, :ssppsup_na, 
        :ssppsec_na, :ssppoth_na, :ssppsupm_na,
        default: false, null: false
    end

    change_table(:sspws) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :sspwrec_na, :sspwtrain_na, :sspwcomp_na, :sspwoth_na, :sspwrecm_na, :sspwcompm_na,
        default: false, null: false
    end

    change_table(:ssvehs) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :ssvehrent_na, :ssvehcount_na, :ssvehfuel_na, :ssvehins_na,
        default: false, null: false
    end

    change_table(:postages) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :sspossbal_na, :ssposuo_na, :ssposvbmo_na, :ssposvbmi_na, 
        :ssposvbmoth_na, :ssposoth_na, :ssposaddsepm_na,
        default: false, null: false
    end
  end
end
