class Election < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  # has_many :survey_responses, dependent: :destroy, inverse_of: :election
  default_scope { order(election_dt: :desc) }

  YEAR_ORDER = {
    '2004 Presidential Primary Election'      => 0,
    '2004 Presidential General Election'      => 1,
    '2005 Statewide Special Election'         => 2,
    '2006 Gubernatorial Primary Election'     => 3,
    '2006 General Election'                   => 4,
    '2008 Presidential Primary Election'      => 5,
    '2008 Statewide Direct Primary Election'  => 6,
    '2008 Presidential General Election'      => 7,
    '2009 Statewide Special Election'         => 8,
    '2010 Statewide Direct Primary Election'  => 9,
    '2010 General Election'                   => 10,
    '2012 Presidential Primary Election'      => 11,
    '2012 Presidential General Election'      => 12,
    '2014 Statewide Direct Primary Election'  => 13,
    '2014 General Election'                   => 14
  }


  def index
    YEAR_ORDER[name]
  end
end
