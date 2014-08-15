class MakeCategoryTbls < ActiveRecord::Migration

def change

 create_table :salbals do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salbaldesign
 t.integer :salbaltrans
 t.integer :salbalorder
 t.integer :salbalmail
 t.integer :salbalother
 t.integer :salbaltotal
 t.integer :salbalpsrp
 t.integer :salbalpsop
 t.integer :salbaltsrp
 t.integer :salbaltsop
 t.integer :salbaltotbe
 t.integer :salbaltotbep
 t.integer :salbalbeps
 t.integer :salbalbepsp
 t.integer :salbalbets
 t.integer :salbalbetsp
 t.integer :salbaltothrs
 t.integer :salbalhrsps
 t.integer :salbalhrsts
 t.text :salbalcomment
 t.timestamps
 t.string :current_step, index: true
 end

create_table :salpps do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salppsurvey
 t.integer :salpporder
 t.integer :salppve
 t.integer :salppdelve
 t.integer :salpppay
 t.integer :salpppubnot
 t.integer :salppoth
 t.integer :salpptot
 t.integer :salpppsrp
 t.integer :salpppsop
 t.integer :salpptsrp
 t.integer :salpptsop
 t.integer :salpptotbe
 t.integer :salpptotbep
 t.integer :salppbeps
 t.integer :salppbepsp
 t.integer :salppbets
 t.integer :salppbetsp
 t.integer :salpptothrs
 t.integer :salpphrsps
 t.integer :salpphrsts
 t.text :salppcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :salpws do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salpwrec
 t.integer :salpwdvtrain
 t.integer :salpwtrain
 t.integer :salpwpay
 t.integer :salpwoth
 t.integer :salpwtot
 t.integer :salpwpsrp
 t.integer :salpwpsop
 t.integer :salpwtsrp
 t.integer :salpwrtsop
 t.integer :salpwtotbe
 t.integer :salpwtotbep
 t.integer :salpwbeps
 t.integer :salpwbepsp
 t.integer :salpwbets
 t.integer :salpwbetsp
 t.integer :salpwtothrs
 t.integer :salpwhrsps
 t.integer :salpwhrsts
 t.text :salpwhcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :salvbms do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salvbmoutr
 t.integer :salvbmappro
 t.integer :salvbmuoapp
 t.integer :salvbmusps
 t.integer :salvbmproces
 t.integer :salvbmoth
 t.integer :salvbmtot
 t.integer :salvbmpsrp
 t.integer :salvbmpsop
 t.integer :salvbmtsrp
 t.integer :salvbmtsop
 t.integer :salvbmtotbe
 t.integer :salvbmtotbep
 t.integer :salvbmbeps
 t.integer :salvbmbepsp
 t.integer :salvbmbets
 t.integer :salvbmbetsp
 t.integer :salvbmtothrs
 t.integer :salvbmhrsps
 t.integer :salvbmhrsts
 t.text :salvbmcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :salbcs do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salbcinh
 t.integer :salbcamor
 t.integer :salbcchca
 t.integer :salbcsec
 t.integer :sabcoth
 t.integer :salbctot
 t.integer :salbcpsrp
 t.integer :salbcpsop
 t.integer :salbctsrp
 t.integer :salbctsop
 t.integer :salbctotbe
 t.integer :salbctotbep
 t.integer :salbcbeps
 t.integer :salbcbepsp
 t.integer :salbcbets
 t.integer :salbcbetsp
 t.integer :salbctothrs
 t.integer :salbchrsps
 t.integer :salbchrsts
 t.text :salbccomment
 t.string :current_step, index: true
 t.timestamps
 end

 create_table :salcans do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salcanprep
 t.integer :salcanproc
 t.integer :slacanoth
 t.integer :salcantot
 t.integer :salcanpsrp
 t.integer :salcanpsop
 t.integer :salcantsrp
 t.integer :salcantsop
 t.integer :salcanbe
 t.integer :salcanbep
 t.integer :salcanbeps
 t.integer :salcanbepsp
 t.integer :salcanbets
 t.integer :salcanbetsp
 t.integer :salcantothrs
 t.integer :salcanhrsps
 t.integer :salcanhrsts
 t.text :salcancomment
 t.string :current_step, index: true
 t.timestamps
 end

 create_table :salmeds do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salmedprep
 t.integer :salmedhandl
 t.integer :salmedtot
 t.integer :salmedpsrp
 t.integer :salmedpsop
 t.integer :salmedtsrp
 t.integer :salmedtsop
 t.integer :salmedbe
 t.integer :salmedbep
 t.integer :salmedbeps
 t.integer :salmedbepsp
 t.integer :salmedbets
 t.integer :salmedbetsp
 t.integer :salmedhrs
 t.integer :salmedhrsps
 t.integer :salmedhrsts
 t.text :salmedcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :saldojos do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :saldojomc
 t.integer :saldojotot
 t.integer :saldojopsrp
 t.integer :saldojopsop
 t.integer :saldojotsrp
 t.integer :saldojotsop
 t.integer :saldojobe
 t.integer :saldojobep
 t.integer :saldojobeps
 t.integer :saldojobepsp
 t.integer :saldojobets
 t.integer :saldojobetsp
 t.integer :saldojohrs
 t.integer :saldojohrsps
 t.integer :saldojohrsts
 t.text :saldojocomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :saloths do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :salothvoed
 t.integer :salothvore
 t.integer :salothelcal
 t.integer :salothstind
 t.integer :salothvoros
 t.integer :salother
 t.integer :salothtot
 t.integer :salothpsrp
 t.integer :salothpsop
 t.integer :salothtsrp
 t.integer :salothtsop
 t.integer :salothbe
 t.integer :salothbep
 t.integer :salothbeps
 t.integer :salothbepsp
 t.integer :salothbets
 t.integer :salothbetsp
 t.integer :salothhrs
 t.integer :salothhrsps
 t.integer :salothhrsts
 t.text :salothcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :ssbals do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :ssballayout
 t.integer :ssbaltransl
 t.integer :ssbalpri
 t.integer :ssbalprisb
 t.integer :ssbalprisben
 t.integer :ssbalprisbch
 t.integer :ssbalprisbko
 t.integer :ssbalprisbsp
 t.integer :ssbalrpisbvi
 t.integer :ssbalprisbja
 t.integer :ssbalprisbta
 t.integer :ssbalprisbkh
 t.integer :ssbalprisbhi
 t.integer :ssbalprisbth
 t.integer :ssbalprisbfi
 t.integer :ssbalprisbml
 t.integer :ssbalpriob
 t.integer :ssbalprioben
 t.integer :ssbalpriobch
 t.integer :ssbalpriobko
 t.integer :ssbalpriobsp
 t.integer :ssbalpriobvi
 t.integer :ssbalpriobja
 t.integer :ssbalpriobta
 t.integer :ssbalpriobkh
 t.integer :ssbalpriobhi
 t.integer :ssbalpriobth
 t.integer :ssbalpriobfi
 t.integer :ssbalpriobml
 t.integer :ssbalprivbm
 t.integer :ssbalpriuo
 t.integer :ssbalpriprot
 t.integer :ssbalpriprou
 t.integer :ssbalpriship
 t.integer :ssbalprioth
 t.text :ssbalcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :postages do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :sspossbal
 t.integer :ssposuo
 t.integer :ssposvbmo
 t.integer :ssposvbmi
 t.integer :ssposvbmoth
 t.integer :ssposoth
 t.text :ssposcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :sspws do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :sspwrec
 t.integer :sspwtrain
 t.integer :sspwcomp
 t.integer :sspwoth
 t.text :sspwcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :sspps do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :ssppsurvey
 t.integer :sspprent
 t.integer :ssppmod
 t.integer :ssppdelive
 t.integer :ssppsup
 t.integer :ssppsec
 t.integer :ssppoth
 t.text :ssppcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :ssvehs do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :ssvehrent
 t.integer :ssvehcount
 t.integer :ssvehfuel
 t.integer :ssvehins
 t.text :ssvehcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :sscans do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :sscanprint
 t.text :sscancomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :ssmeds do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :ssmedprint
 t.text :ssmedcomment
 t.string :current_step, index: true
 t.timestamps
 end

create_table :ssoths do |t|
 t.integer :election_year_id
 t.integer :county
 t.integer :ssothoutrea
 t.integer :ssothbcounth
 t.integer :ssothbcsec
 t.integer :ssothwareh
 t.integer :ssothelcom
 t.integer :ssothphbank
 t.integer :ssothwebsite
 t.integer :ssothcpst
 t.integer :ssothoth
 t.text :ssothcomment
 t.string :current_step, index: true
 t.timestamps
 end


 create_table :filter_costs do | t|
  t.text :fieldlist
  t.string  :filtertype
  t.timestamps
end

end

end
