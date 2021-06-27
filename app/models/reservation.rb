class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  with_options presence: true do
   validates :start_date
   validates :end_date
   validates :person
   validates :confirming
  end
  
  validate :end_date_before_today
  
  def end_date_before_today
    return if end_date.blank?
    if end_date < Date.today 
    errors.add(:end_date, "は今日以降のものを選択してください")  
    end
  end

  validate :start_date_before_today

  def start_date_before_today
    return if start_date.blank?
    if start_date < Date.today 
    errors.add(:start_date, "は今日以降のものを選択してください")  
    end
  end

  validate :start_end_check

  def start_end_check
    errors.add(:end_date, "は開始日より前の日付は登録できません") unless
    self.start_date < self.end_date 
  end

  validates_acceptance_of :confirming
  after_validation :check_confirming

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  mount_uploader :image, ImageUploader
end
