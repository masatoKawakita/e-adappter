module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y.%m.%d")
  end

  def detail_time(time)
    time.strftime("%Y.%m.%d %H:%M")
  end

  def start_time(time)
    time.strftime("%Y年%m月")
  end
end
