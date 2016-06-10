# * LA variables.

# compute canvas=salbccanvone.
# compute pollworker=sumall_pollw.
# compute pollplace=sumall_pollp.
# compute postage=SS_POST.
# compute sob_print=sum.1(:salbaldesign, :ssbalprisben, :ssbalprioben).
# compute multiling= sum.1(:salbaltrans, :ssbaltransl, :ssbalprisbch, :ssbalprisbko,
#         :ssbalprisbsp, :ssbalrpisbvi, :ssbalprisbja, :ssbalprisbta, :ssbalprisbkh, :ssbalprisbhi, :ssbalprisbth).
# compute provisional=sum.1(salbcprocpb).
# compute election_costs_no_benefits= eptotelectc-ben_total.

# compute pct_canvas=canvas/max_direct_survey.
# compute pct_pollworker=pollworker/max_direct_survey.
# compute pct_pollplace=pollplace/max_direct_survey.
# compute pct_postage=postage/max_direct_survey.
# compute pct_sob_print=sob_print/max_direct_survey.
# compute pct_multiling=multiling/max_direct_survey.
# compute pct_provisional=provisional/max_direct_survey.

# variable labels canvas "Canvas Cost" / pollworker "Pollworker Cost" / pollplace "Polling Place Cost"
#                       /postage "Postage Cost" / sob_print "Ballot Printing Cost" / multiling "Multi-lingual Cost"
#                       /provisional "provional Ballot Processing Cost"
#                       /pct_canvas "Canvas Cost Pct" / pct_pollworker "Pollworker Cost Pct" / pct_pollplace "Polling Place Cost Pct"
#                       /pct_postage "Postage Cost Pct" / pct_sob_print "Ballot Printing Cost Pct" / pct_multiling "Multi-lingual Cost Pct"
#                       /pct_provisional "provional Ballot Processing Cost Pct".


# compute max_direct_survey=max.1(sum_salaries_services_supplies, sum_task_services_supplies).
# variable labels max_direct_survey "Direct Costs from Survey: Maximum".

# compute sum_salaries_services_supplies=sum.1(SS_TOTAL,salben_total).


# # TOTAL a/k/a max_direct_survey
# compute max_direct_survey=max.1(sum_salaries_services_supplies, sum_task_services_supplies).
# variable labels max_direct_survey "Direct Costs from Survey: Maximum".

# # WHY is SS_TOTAL in both of these?
# compute sum_task_services_supplies=sum.1(SS_TOTAL,saltask_total).
# compute sum_salaries_services_supplies=sum.1(SS_TOTAL,salben_total).

# Variable labels sum_salaries_services_supplies "Election Costs: Salaries, Services and Supplies".
# Variable labels sum_task_services_supplies "Election Costs: Tasks, Services and Supplies".


# compute SS_TOTAL=sum.1(SS_BALP to SS_OTH).
# Variable labels SS_TOTAL "Services and Supplies: Total".

# compute SS_BALP= sum.1(ssballayout,ssbaltransl,
# ssbalprisben,ssbalprisbch,ssbalprisbko,ssbalprisbsp,ssbalrpisbvi,ssbalprisbja,ssbalprisbta,ssbalprisbkh,
# ssbalprisbhi,ssbalprisbth,ssbalprisbfi,ssbalprisb1mc,ssbalprisb2mc,ssbalprisb3mc,ssbalprioben,
# ssbalpriobch,ssbalpriobko,ssbalpriobsp,ssbalpriobvi,ssbalpriobja,ssbalpriobta,ssbalpriobkh,ssbalpriobhi,
# ssbalpriobth,ssbalpriobfi,ssbalpriob1mc,ssbalpriob2mc,ssbalpriob3ml,ssbalprivbm,ssbalpriuo,
# ssbalpriprot,ssbalpriprou,ssbalpriship,ssbalprioth).
# execute.
# variable labels  SS_BALP "Services and Supplies: Ballot Printing".

# compute SS_POST =sum.1(sspossbal,ssposuo,ssposvbmo,ssposvbmi,ssposvbmoth,ssposaddsepm,ssposoth).
# Variable labels  SS_POST "Services and Supplies: Postage".

# compute SS_POLLP=sum.1(ssppsurvey,sspprent,ssppmod,ssppdelive,ssppsup,ssppsupm,ssppsec,ssppoth).
# Variable labels  SS_POLLP "Services and Supplies: Polling Places".

# compute SS_POLLW=sum.1(sspwrec,sspwrecm,sspwtrain,sspwcomp,sspwcompm,sspwoth).
# Variable labels  SS_POLLW "Services and Supplies: Poll Workers".

# compute SS_BALLC=sum.1(ssbcprocvbh,ssbcprocpbh,ssbcprocs,ssbcbcounth,ssbcbcounts,ssbccanvh,ssbccanvs,ssbcpcsec).
# Variable labels  SS_BALLC "Services and Supplies: Ballot Counting".

# compute SS_VEH=sum.1(ssvehrent,ssvehcount,ssvehfuel,ssvehins).
# Variable labels  SS_VEH "Services and Supplies: Vehicles".

# compute SS_CAND=sum.1(sscanprint,0).
# Variable labels  SS_CAND "Services and Supplies: Candidate Printing".

# compute SS_MED=sum.1(ssmedprint,ssmedcampm).
# Variable labels  SS_MED "Services and Supplies: Media".

# compute SS_OTH=sum.1(ssothoutrea,ssothoutream,ssothrevm,ssothhotm,ssothdatam,ssothwareh,ssothelcom,ssothphbank,ssothwebsite,ssothcpst,ssothoth,ssothothm).
# Variable labels  SS_Oth "Services and Supplies: Other".



# query = <<-SQL
# SELECT 
#   bp.id,
#   bp.election_id,
#   bp.county_id,
#   SUM(bp.cost) as cost
# FROM (
#   (
#     SELECT 
#       sal.id,
#       sal.election_id,
#       sal.county_id,
#       response_values.integer_value AS cost
#     FROM survey_responses AS sal
#     INNER JOIN response_values
#     ON sal.id = response_values.survey_response_id 
#       AND response_values.question_id = 218
#       AND NOT sal.election_id = 59
#   )
#   UNION 
#   (
#     SELECT 
#       ss.id,
#       ss.election_id, 
#       ss.county_id, 
#       SUM(response_values.integer_value) AS cost
#     FROM survey_responses AS ss
#     INNER JOIN response_values
#     ON ss.id = response_values.survey_response_id 
#       AND response_values.question_id IN(374, 391) 
#       AND NOT ss.election_id = 59
#     GROUP BY ss.id
#   ) 
# ) AS bp
# WHERE bp.id NOT IN (
#   SELECT srs.id
#   FROM survey_responses AS srs
#   WHERE srs.response_type IN('Salbal', 'Ssbal')
#   GROUP BY srs.election_id, srs.county_id
#   HAVING COUNT(srs.response_type) = 1
# ) 
# GROUP BY bp.election_id, bp.county_id

# SQL
# b=ActiveRecord::Base.connection.exec_query query

# :salbaltrans, :ssbaltransl, :ssbalprisbch, :ssbalprisbko, :ssbalprisbsp, :ssbalrpisbvi, :ssbalprisbja, :ssbalprisbta, :ssbalprisbkh, :ssbalprisbhi, :ssbalprisbth

cost_components = [
  {
    name: 'canvassing',
    components: [
      {
        survey: 'Salbc',
        codes: [:salbccanvone]
      }
    ]
  },
  {
    name: 'ballot_printing',
    components: [
      {
        survey: 'Salbal',
        codes: [:salbaldesign]
      },
      {
        survey: 'Ssbal',
        codes: [:ssbalprisben, :ssbalprioben]
      }
    ]
  },
  {
    name: 'multi_lingual_ballots',
    components: [
      {
        survey: 'Salbal',
        codes: [:salbaltrans]
      },
      {
        survey: 'Ssbal',
        codes: [
          :ssbaltransl, :ssbalprisbch, :ssbalprisbko, 
          :ssbalprisbsp, :ssbalrpisbvi, :ssbalprisbja, 
          :ssbalprisbta, :ssbalprisbkh, :ssbalprisbhi, 
          :ssbalprisbth
        ]
      }
    ]
  },
  {
    name: 'provisional_ballots',
    components: [
      {
        survey: 'Salbc',
        codes: [:salbcprocpb]
      }
    ]
  },
  {
    name: 'polling_places',
    components: [
      {
        survey: 'Salpp',
        codes: [:salppsurvey, :salpporder, :salppve, :salppdelve, :salpppay, :salpppubnot, :salppemattr, :salppoth]
      },
      {
        survey: 'Sspp',
        codes: [:ssppsurvey, :sspprent, :ssppmod, :ssppdelive, :ssppsup, :ssppsupm, :ssppsec, :ssppoth]
      }
    ]
  },
  {
    name: 'poll_workers',
    components: [
      {
        survey: 'Sspw',
        codes: [:sspwrec, :sspwrecm, :sspwtrain, :sspwcomp, :sspwcompm, :sspwoth]
      },
      {
        survey: 'Salpw',
        codes: [:salpwrec, :salpwrecm, :salpwdvtrain, :salpwtrain, :salpwpay, :salpwoth]
      }
    ]
  }
]

def compile_costs(cost_components)
  require 'json'
  require 'csv'

  cost_arr = []
  cost_components.each_with_index do |cost, j|
    component_arr = []
    cost[:components].each_with_index do |el, i|
      component_arr[i] = <<-SQL
        (
          SELECT 
            comp#{i}.id,
            comp#{i}.election_id, 
            comp#{i}.county_id, 
            SUM(response_values.integer_value) AS cost
          FROM survey_responses AS comp#{i}
          INNER JOIN response_values
          ON comp#{i}.id = response_values.survey_response_id 
            AND response_values.question_id IN(#{Question.where(field: el[:codes]).pluck(:id).join(',')}) 
            AND response_values.integer_value IS NOT NULL
            AND NOT comp#{i}.county_id = 59
          GROUP BY comp#{i}.id
        ) 
      SQL
    end

    cost_arr[j] = <<-SQL
      SELECT 
          cost.election_id
        , cost.county_id
        , "#{cost[:name]}" AS cost_type
        , SUM(cost.cost) AS cost
      FROM (
        #{ component_arr.join(' UNION ') }
      ) AS cost
      WHERE cost.id NOT IN (
        SELECT srs.id
        FROM survey_responses AS srs
        WHERE srs.response_type IN(#{ cost[:components].map {|e| "'#{e[:survey]}'" }.join(',') } )
        GROUP BY srs.election_id, srs.county_id
        HAVING COUNT(srs.response_type) < #{cost[:components].length}
      ) 
      GROUP BY cost.election_id, cost.county_id
    SQL
  end
  query = cost_arr.join(' UNION ')
  result = ActiveRecord::Base.connection.exec_query(query)
  

  e_index = {}
  Election.all.each {|e| e_index[e.id] = e.index}


  CSV.open('compiled_costs.csv', 'wb') do |csv|
    csv << ['electionId', 'countyId', 'costId', 'cost']
    result.each do |c|
      csv << [e_index[c['election_id']], c['county_id'], c['cost_type'], c['cost']]
    end
  end

  county_groups = result.group_by {|d| e_index[d['election_id']] }
  counties = {}
  county_groups.each do |k,v|
    ids = v.map { |cost| cost['county_id'] }.uniq.sort { |a,b| a<=>b }
    counties[ k ] = ids
  end

  File.open("counties_reporting_by_election.json","w") do |f|
    f.write(counties);
  end

  index_id = Election.all.unscope(:order).order(election_dt: :asc)

  # still ordered ascending by id
  q_ids = Question.where(
    field: ['epppbalpap', 'epbaltype', 'epvbmret', 'epcand', 'epmeasr', 'eptotelectc']
  ).pluck(:id)
  CSV.open("ep_stats.csv", 'wb') do |csv|
    csv << ['electionId', 'countyId', 'epppbalpap', 'epbaltype', 'epvbmret', 'epcand', 'epmeasr', 'eptotelectc']
    counties.each do |e_index, county_ids|
      e_id = index_id[e_index].id
      county_ids.each do |c_id|
        sr = SurveyResponse.find_by(
          response_type: 'ElectionProfile', election_id: e_id, county_id: c_id
        )

        if sr
          vals = sr.values.where(question_id: q_ids)
          csv << [e_index, c_id].concat(q_ids.map { |id|
            vals.find_by(question_id:id).integer_value
          })
        else
          csv << [e_index, c_id].concat(q_ids.map { |id| nil })
        end
      end
    end
  end
end


# ac = compile_cost cc
# # check which county_id, election_id combinations have all the response_types im looking for

# # CANVAS COST - 0.16% of total cost, nothing
# :salbccanvone

# # BALLOT PRINTING COST -- Salbal Ssbal
# :salbaldesign, :ssbalprisben, :ssbalprioben

# # MUTLI-LINGUAL COST -- Ssbal Salbal
# :salbaltrans, :ssbaltransl, :ssbalprisbch, :ssbalprisbko, :ssbalprisbsp, :ssbalrpisbvi, :ssbalprisbja, :ssbalprisbta, :ssbalprisbkh, :ssbalprisbhi, :ssbalprisbth

# # PROVISIONAL BALLOT COST -- Salbal
# :salbcprocpb

# # POLLING PLACE -- Sspp Salpp
# "Total Tasks, Services and Supplies: Polling Place"
# :ssppsurvey, :sspprent, :ssppmod, :ssppdelive, :ssppsup, :ssppsupm, :ssppsec, :ssppoth, :salppsurvey, :salpporder, :salppve, :salppdelve, :salpppay, :salpppubnot, :salppemattr, :salppoth

# # "Services and Supplies: Polling Places"
# # :ssppsurvey, :sspprent, :ssppmod, :ssppdelive, :ssppsup, :ssppsupm, :ssppsec, :ssppoth
# # "Total in-house staff cost, : Tasks: Polling places"
# # :salppsurvey, :salpporder, :salppve, :salppdelve, :salpppay, :salpppubnot, :salppemattr, :salppoth


# # POLLWORKERS Ssbal
# "Total Tasks, : Services and Supplies: Poll Workers".
# :sspwrec, :sspwrecm, :sspwtrain, :sspwcomp, :sspwcompm, :sspwoth, :salpwrec, :salpwrecm, :salpwdvtrain, :salpwtrain, :salpwpay, :salpwoth

# # "Services and Supplies: Poll Workers"
# # :sspwrec, :sspwrecm, :sspwtrain, :sspwcomp, :sspwcompm, :sspwoth
# # "Total in-house staff cost, Tasks:  Poll workers"
# # :salpwrec, :salpwrecm, :salpwdvtrain, :salpwtrain, :salpwpay, :salpwoth
