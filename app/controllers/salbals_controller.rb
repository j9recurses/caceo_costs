class SalbalsController < SurveysController
#change params to get working
    # Never trust parameters from the scary internet, only allow the white list through.
    def salbal_params
      params.require(:salbal).permit(
      :salbaldesign, :salbaltrans, :salbalorder, :salbalmail, :salbalother, :salbalpsrp, :salbalpsop, :salbaltsrp, :salbaltsop, :salbaltotbe, :salbaltotbep, :salbalbeps, :salbalbepsp, :salbalbets, :salbalbetsp, :salbaltothrs, :salbalhrsps, :salbalhrsts, :salbalcomment,  :election_year_id, :county, :current_step
      )
    end
end
