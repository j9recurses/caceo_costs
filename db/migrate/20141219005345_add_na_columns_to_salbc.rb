class AddNaColumnsToSalbc < ActiveRecord::Migration
  def change
    change_table(:salbcs) do |t|
      t.remove :current_step
      t.rename :county, :county_id
      t.boolean :salbcsec_na, :sabcoth_na, :salbcpsrp_na, :salbcpsop_na, 
        :salbctsrp_na, :salbctsop_na, :salbcbeps_na, :salbcbepsp_na, 
        :salbcbets_na, :salbcbetsp_na, :salbchrsps_na, :salbchrsts_na, 
        :salbcnvbmp_na, :salbcvbm_na, :salbcprov_na, :salbcprocpb_na, 
        :salbccanvdb_na, :salbccanvone_na, :salbccanvdre_na, :salbccanvpa_na, 
        :salbccanvsa_na, :salbccanvva_na, :salbccanvoth_na,
        default: false, null: false
    end
  end
end
