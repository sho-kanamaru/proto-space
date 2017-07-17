module PrototypesHelper
  def prototype_date(prototype)
    prototype.created_at.to_s(:date)
  end

  def set_placeholder
    placeholder = ["Web Design", "UI", "Application"]
  end
end
