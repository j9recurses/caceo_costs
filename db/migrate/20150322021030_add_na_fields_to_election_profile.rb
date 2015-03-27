class AddNaFieldsToElectionProfile < ActiveRecord::Migration
  def change
    change_table :election_profiles do |t|
      t.boolean :epems_na, :eppphwscan_na, :eppphwdre_na, 
        :eppphwmarkd_na, :eppphwpollbk_na, :eppphwoth_na, 
        :epetallysys_na, :epppbalpap_na, :epppbalaccsd_na, 
        :eprv_na, :eppploc_na, :epprecwpp_na, :epprecvbm_na, 
        :epbaltype_na, :epbalpage_na, :epbalsampvip_na, 
        :epvipinsrt_na, :epbalofficl_na, :epvbmmail_na, 
        :epvbmmailprm_na, :epvbmmailmbp_na, :epvbmmailuo_na, 
        :epvbmotc_na, :epvbmret_na, :epvbmretprm_na, 
        :epvbmretmbp_na, :epvbmretuo_na, :epvbmundel_na, 
        :epvbmchal_na, :epvbmprovc_na, :epvbmprovnc_na, 
        :epcand_na, :epcandfsc_na, :epcandcd_na, 
        :epcandwi_na, :epcandwifsc_na, :epcandwicd_na, 
        :epmeasr_na, :epmeasrfsc_na, :epmeasrcd_na, 
        :epicrp_na, :epicrpfed_na, :epicrpcounty_na, 
        :epicrpown_na, :epicrpoth_na, :eptotindirc_na, 
        :eptotelectc_na, :epcostallrg_na, :epcostallpre_na, 
        :epcostallopp_na, :epcostalloth_na, :eptotbilled_na, 
        :eptotcounty_na, :eptotsb90c_na, :eptotsb90r_na, 
        :epmandates_na, :epppbalpapar_na, :epppbalpapbu_na, 
        :epppbalpapot_na, :epvbmretpp_na, :epvbmirevl_na, 
        :epvbmrrevl_na, :epprovcwbt_na, :epprovcwp_na, 
        :epprovncvnr_na, :epprovncbrva_na, :epprovncoth_na, 
        :epprovvbm_na, :epprovnor_na, :epprovhava_na, 
        :epprovunivs_na, :epprovoutr_na, :epcanvdrere_na, 
        :eplangvra_na, :eplangcaec_na, :eplangloc_na, 
        :eptotcandca_na, :eptotvolunth_na, :eplangvrao_na, 
        :eplangcaeco_na,
        default: false, null: false
    end
  end
end
