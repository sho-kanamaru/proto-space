module PrototypesHelper
  def prototype_date(prototype)
    prototype.created_at.to_s(:date)
  end
end
