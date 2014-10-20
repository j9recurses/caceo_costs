class AddMoreCostCategoryFields < ActiveRecord::Migration
  def change
#remove a bunch of columns
remove_column :ssoths,  :ssothbcounth
remove_column :ssoths, :ssothbcsec
remove_column :salbcs, :salbcinh
remove_column :salbcs,  :salbcamor
remove_column :salbcs,  :salbcchca
#remove_column  :salpps,:salppemattr
#remove_column  :salpws,:salpwrecm,:integer

#change column type
change_column :ssbals, :ssbalpriobml, :string
change_column :ssbals, :ssbalprisbml, :string

#need to comment this shit out for deployment
#remove_column  :salpws,:salpwrecm,:integer
#remove_column  :salpps,:salppemattr,:integer
#remove_column  :salpws,:salpwrecm,:integer
#remove_column  :salbcs,:salbcnvbmp,:integer
#remove_column  :salbcs,:salbcvbm,:integer
#remove_column  :salbcs,:salbcprov,:integer
#remove_column  :salbcs,:salbcprocpb,:integer
#remove_column  :salbcs,:salbccanvdb,:integer
#remove_column  :salbcs,:salbccanvone,:integer
#remove_column :salbcs,:salbccanvdre,:integer
#remove_column  :salbcs,:salbccanvpa,:integer
#remove_column  :salbcs,:salbccanvsa,:integer
#remove_column  :salbcs,:salbccanvva,:integer
#remove_column  :salbcs,:salbccanvoth,:integer
#remove_column  :salmeds,:salmedcampm,:integer
#remove_column  :saloths,:salothvoedm,:integer
#remove_column  :saloths,:salothvorepr,:integer
#remove_column  :saloths,:salothrevm,:integer
#remove_column  :saloths,:salothhotm,:integer
#remove_column  :saloths,:salothdatam,:integer
#emove_column  :ssbals,:ssbalprisbmc,:integer
#remove_column  :ssbals,:ssbalpriobmc,:integer
#remove_column  :postages,:ssposaddsepm,:integer
#remove_column  :sspps,:ssppsupm,:integer
#remove_column  :sspws,:sspwrecm,:integer
#remove_column  :sspws,:sspwcompm,:integer
#remove_column  :ssmeds,:ssmedcampm,:integer
#remove_column  :ssoths,:ssothoutream,:integer
#remove_column  :ssoths,:ssothrevm,:integer
#remove_column  :ssoths,:ssothhotm,:integer
#remove_column  :ssoths,:ssothdatam,:integer
#remove_column  :ssoths,:ssothothm,:integer


#need to double check the ssbals fields
add_column  :salpps,:salppemattr,:integer
add_column  :salpws,:salpwrecm,:integer
add_column  :salbcs,:salbcnvbmp,:integer
add_column  :salbcs,:salbcvbm,:integer
add_column  :salbcs,:salbcprov,:integer
add_column  :salbcs,:salbcprocpb,:integer
add_column  :salbcs,:salbccanvdb,:integer
add_column  :salbcs,:salbccanvone,:integer
add_column  :salbcs,:salbccanvdre,:integer
add_column  :salbcs,:salbccanvpa,:integer
add_column  :salbcs,:salbccanvsa,:integer
add_column  :salbcs,:salbccanvva,:integer
add_column  :salbcs,:salbccanvoth,:integer
add_column  :salmeds,:salmedcampm,:integer
add_column  :saloths,:salothvoedm,:integer
add_column  :saloths,:salothvorepr,:integer
add_column  :saloths,:salothrevm,:integer
add_column  :saloths,:salothhotm,:integer
add_column  :saloths,:salothdatam,:integer
add_column  :ssbals,:ssbalprisbmc,:integer
add_column  :ssbals,:ssbalpriobmc,:integer
add_column  :postages,:ssposaddsepm,:integer
add_column  :sspps,:ssppsupm,:integer
add_column  :sspws,:sspwrecm,:integer
add_column  :sspws,:sspwcompm,:integer
add_column  :ssmeds,:ssmedcampm,:integer
add_column  :ssoths,:ssothoutream,:integer
add_column  :ssoths,:ssothrevm,:integer
add_column  :ssoths,:ssothhotm,:integer
add_column  :ssoths,:ssothdatam,:integer
add_column  :ssoths,:ssothothm,:integer

#create this table: ballot counting is a new cost category
create_table :ssbcs  do |t|
t.integer :ssbcprocvbh
t.integer :ssbcprocpbh
t.integer :ssbcprocs
t.integer :ssbcbcounth
t.integer :ssbcbcounts
t.integer :ssbccanvh
t.integer :ssbccanvs
t.integer :ssbcpcsec
t.text :ssbccomment
end

  end
end




